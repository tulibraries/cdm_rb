require 'open-uri'
require 'nokogiri'

module CDM
  module Api
    class Collections < ApiClient

      attr_reader :collections

      def local_init(args)
        @collections = get_list(args)
      end

      def request(args)
        format = set_format args.fetch(:format, nil)
        open("#{@base_url}dmGetCollectionList/#{format}")
      end

      def get_list(args)
        xml = Nokogiri.XML request(args)



      end

    end
  end
end
