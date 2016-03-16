require 'open-uri'
require 'nokogiri'

module CDM
  module Collections

    def self.request(args)
      format = args.fetch(:format) || 'xml'
      open("#{args[:url]}dmGetCollectionList/#{format}")
    end

    def self.get_list(args)
      response = request(args)
      parsed = Nokogiri.XML response

    end

  end
end
