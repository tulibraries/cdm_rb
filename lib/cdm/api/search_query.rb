module CDM
  module Api
    class SearchQuery < ApiClient

      attr_reader :suppress_pages, :docptr, :suggest, :facets, :showunpub, :denormalize_facets

      # https://www.oclc.org/support/services/contentdm/help/customizing-website-help/other-customizations/contentdm-api-reference/dmquery.en.html
      def local_init(args)
        @alias               = args.fetch(:alias, nil)
        @searchstrings       = args.fetch(:searchstrings, nil)
        @fields              = args.fetch(:fields, nil)
        @sortby              = args.fetch(:sortby, nil)
        @max_recs            = args.fetch(:max_recs, nil)
        @start               = args.fetch(:start, nil)
        @suppress_pages      = args.fetch(:suppress_pages, '1')
        @docptr              = args.fetch(:docptr, '0')
        @suggest             = args.fetch(:suggest, '0')
        @facets              = args.fetch(:facets, '0')
        @showunpub           = args.fetch(:showunpub, '0')
        @denormalize_facets  = args.fetch(:denormalize_facets, '0')
      end

      # Gets a single page of results for a query
      def results
        send_query
      end

      # Iterates over all pages of results if the totel number of results is
      # greater than the max_recs
      def all_items

      end

      # pardon me as I barf all over this url. UGH!!!
      def query_string
        "#{base_url}dmQuery/#{collection_alias}/#{searchstrings}/#{fields}/" +
            "#{sortby}/#{max_recs}/#{start}/#{suppress_pages}/#{docptr}/#{suggest}/" +
            "#{facets}/#{showunpub}/#{denormalize_facets}/#{response_format}"
      end

      def collection_alias
        @alias || 'all'
      end

      def searchstrings
        @searchstrings || '0' #defaults to browsing the collection
      end

      def fields
        @fields || 'dmrecord'
      end

      def sortby
        @sortby || 'dmrecord'
      end

      def max_recs
        @max_recs  || '1024'
      end

      def start
        @start || '1'
      end

    end
  end
end
