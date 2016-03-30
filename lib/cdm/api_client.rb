require 'open-uri'
require 'nokogiri'

module CDM
  class ApiClient

    include CDM::Api::Urls
    include CDM::Api::Defaults

    attr_reader :base_url, :query_args

    def initialize(args)
      @base_url = construct_backend_url args.fetch(:url), args.fetch(:port, nil)
      local_init args
      validate
    end

    # Each subclass will define its own additional initialization logic
    def local_init(args)
    end

    def send_query(args)
      Nokogiri.XML request(args)
    end

    # Each subclass will define its own criteria for validation
    def validate
    end

  end
end
