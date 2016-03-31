module CDM
  module Api
    class ItemInfo < ApiClient

      def local_init(args)
        @collection = args[:collection]
        @id         = args[:id]
        @item       = send_query(args)
      end

      def request(args)
        open("#{@base_url}dmGetItemInfo/#{@collection}/#{@id}/#{format}")
      end

      def raw
        @item.to_xml
      end

      def parsed
        @item
      end

      def to_h
        item_hash = {}
        @item.xpath('/xml').children.each do |child|
          item_hash[child.name] = child.text
        end
        item_hash
      end

      def validate
        message = "Item with that ID does not exist: #{raw}"
        raise ArgumentError, message unless @item.xpath("/error").empty?
      end

    end
  end
end

