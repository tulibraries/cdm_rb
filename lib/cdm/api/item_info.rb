module CDM
  module Api
    class ItemInfo < ApiClient

      def local_init(args)
        @collection = args[:collection]
        @id         = args[:id]
        @item       = get_item(args)
      end

      def get_item(args)
        Nokogiri.XML request(args)
      end

      def request(args)
        format = set_format args.fetch(:format, nil)
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

      #@TODO HANDLE UNKNOWN ITEMS GRACEFULLY
    end
  end
end

