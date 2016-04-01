require 'open-uri'
require 'nokogiri'

module CDM
  class ApiClient

    include CDM::Api::Urls

    attr_reader :base_url, :format

    def initialize(args)
      @base_url = construct_backend_url args.fetch(:url), args.fetch(:port, nil)
      @format = args.fetch(:format, nil)
      local_init args
      validate
    end

    # Each subclass will define its own additional initialization logic
    def local_init(args)
    end

    def send_query
      Nokogiri.XML request
    end

    # Each subclass will define its own criteria for validation
    def validate
    end

    def response_format
      @format || 'xml'
    end

  end
end
