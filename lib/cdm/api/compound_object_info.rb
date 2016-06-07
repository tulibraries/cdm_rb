module CDM
  module Api
    class CompoundObjectInfo < ApiClient

      attr_reader :collection, :id, :compound

      def local_init(args)
        @collection = args[:collection]
        @id         = args[:id]
        @compound = send_query
      end

      def query_string
        "#{base_url}dmGetCompoundObjectInfo/#{collection}/#{id}/#{response_format}"
      end

      def sections
        compound.xpath("/cpd/node//node").map {|node| node.xpath("nodetitle").text}
      end

      def pages
        compound.xpath("/cpd/node//page").map  do |page|
          {
              :title => _page_title(page),
              :id    => _page_id(page)
          }
        end
      end

      def _page_title(page)
        page.xpath('pagetitle').text
      end

      def _page_id(page)
        page.xpath('pageptr').text
      end
    end
  end
end
