# frozen_string_literal: true

require "open-uri"
require "nokogiri"

module CDM
  class ApiClient
    include CDM::Api::Urls

    attr_reader :base_url, :format

    def initialize(args)
      # Keep :url vs :server_url for backwards compatitibilty.
      url = args.fetch(:url, CDM.configuration&.server_url) ||
        CDM::StandardError.new("The cdm server_url is required", args)

      port = args.fetch(:port, CDM.configuration&.server_port)

      @base_url = construct_backend_url url, port
      @format = args.fetch(:format, CDM.configuration&.format)
      local_init args
      validate
    end

    # Each subclass will define its own additional initialization logic
    def local_init(args)
    end

    def send_query
      Nokogiri.XML request
    end

    def request
      open(query_string)
    end

    # Each subclass will define its query string
    def query_string
    end

    # Each subclass will define its own criteria for validation
    def validate
    end

    def response_format
      @format || "xml"
    end
  end
end
