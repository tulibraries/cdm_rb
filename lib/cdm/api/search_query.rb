# frozen_string_literal: true

require "httparty"
require "forwardable"

module CDM
  module Api
    class SearchQueryResponse
      class ResponseError < CDM::StandardError
      end

      extend Forwardable

      def initialize(response)
        @response = response
        validate(response)
      end

      def_delegators :@response, :fetch, :dig, :each, :<<, :[], :[]=

      def total
        self["results"]["pager"]["total"]
      end

      def loggable
        { uri: @raw_response&.request&.uri.to_s
        }.select { |k, v| !(v.nil? || v.empty?) }
      end

      def validate(response)
        if response.code != 200
          log = loggable.merge(response.parsed_response)
          raise ResponseError.new("Failed to query Content DM Sever", log)
        end
      end
    end

    class SearchQuery < ApiClient
      include HTTParty

      attr_reader :suppress_pages, :docptr, :suggest, :facets, :showunpub, :denormalize_facets

      def self.get(args)
        sq = new(args)
        SearchQueryResponse.new(super sq.query_string)
      end

      # https://www.oclc.org/support/services/contentdm/help/customizing-website-help/other-customizations/contentdm-api-reference/dmquery.en.html
      def local_init(args)
        @alias               = args.fetch(:alias, nil)
        @searchstrings       = args.fetch(:searchstrings, nil)
        @fields              = args.fetch(:fields, nil)
        @sortby              = args.fetch(:sortby, nil)
        @max_recs            = args.fetch(:max_recs, nil)
        @start               = args.fetch(:start, nil)
        @suppress_pages      = args.fetch(:suppress_pages, "1")
        @docptr              = args.fetch(:docptr, "0")
        @suggest             = args.fetch(:suggest, "0")
        @facets              = args.fetch(:facets, "0")
        @showunpub           = args.fetch(:showunpub, "0")
        @denormalize_facets  = args.fetch(:denormalize_facets, "0")
      end

      # Gets a single page of results for a query
      def results
        send_query
      end

      # pardon me as I barf all over this url. UGH!!!
      def query_string
        "#{base_url}dmQuery/#{collection_alias}/#{searchstrings}/#{fields}/" +
            "#{sortby}/#{max_recs}/#{start}/#{suppress_pages}/#{docptr}/#{suggest}/" +
            "#{facets}/#{showunpub}/#{denormalize_facets}/#{response_format}"
      end

      def collection_alias
        @alias || "all"
      end

      def searchstrings
        q = @searchstrings

        if !q.nil? && !q.match?(/\^/)
          "CISOSEARCHALL^#{q}^all"
        elsif !q.nil? && q.match?(/\^/)
          q
        else
          "0"
        end
      end

      def fields
        @fields || "dmrecord"
      end

      def sortby
        @sortby || "dmrecord"
      end

      def max_recs
        @max_recs || CDM.configuration&.max_recs || "1024"
      end

      def start
        @start || "1"
      end

      def start=(number)
        @start = number
      end
    end
  end
end
