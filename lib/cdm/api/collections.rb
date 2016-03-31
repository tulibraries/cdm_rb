module CDM
  module Api
    class Collections < ApiClient

      def local_init(args)
        @collections = send_query(args)
      end

      def parsed
        @collections
      end

      def list
        @collections.xpath('/collections/collection').map do |collection|
          { alias_for(collection) => name_of(collection) }
        end
      end

      def to_h
        hash = {}
        @collections.xpath('/collections/collection').each do |collection|
          hash[alias_for collection] =  name_of collection
        end
        hash
      end

      def request(args)
        open("#{@base_url}dmGetCollectionList/#{format}")
      end

      # given a Nokogiri object for a single collection, returns the collection alias
      def alias_for(collection)
        collection.xpath('secondary_alias').text
      end

      # given a Nokogiri object for a single collection, returns the collection name
      def name_of(collection)
        collection.xpath('name').text
      end


    end
  end
end
