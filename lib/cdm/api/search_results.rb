module CDM
  module Api
    class SearchResults

      attr_accessor :data

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
        @results.xpath('records/record')
      end

      def next_page
        @query.start = start + records_per_page
        next_page = self.class.new :result => @query.results, :query => @query
        @data = next_page.data
        @results = results
        self
      end

      def self.record_id(record)
        record.xpath('pointer').text
      end

      # Iterates over all pages of results if the total number of results is
      # greater than the max_recs
      def all_items
        total.times do |i|
          yield records[i - start]
          unless i < start + records_per_page
            next_page
          end
        end
      end
    end
  end
end
