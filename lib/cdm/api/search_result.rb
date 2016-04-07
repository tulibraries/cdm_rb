module CDM
  module Api
    class SearchResult

      def initialize(args)
        @data = args[:result]
        @results = results
        @query   = args[:query]
      end

      def results
        @data.xpath('/results')
      end

      def pager
        @results.xpath('pager')
      end

      def total
        pager.xpath('total').text.to_i
      end

      def start
        pager.xpath('start').text.to_i
      end

      def records_per_page
        pager.xpath('maxrecs').text.to_i
      end

      def records
        @results.xpath('/records')
      end


      # Iterates over all pages of results if the total number of results is
      # greater than the max_recs
      def all_items

      end
    end
  end
end
