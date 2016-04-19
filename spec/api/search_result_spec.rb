
  # setup the webmock queries
RSpec.configure do |config|
  config.before(:each) do
    # Valid arameters and valid response
    stub_request(:get, /example.com/)
        .with(:query => {'q' => 'dmQuery/all/0/dmrecord/dmrecord/1024/1/1/0/0/0/0/0/xml'})
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + '/fixtures/search/response.xml').read
        )
    # Valid arameters and valid response, second page
    stub_request(:get, /example.com/)
        .with(:query => {'q' => 'dmQuery/all/0/dmrecord/dmrecord/1024/11/1/0/0/0/0/0/xml'})
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + '/fixtures/search/response_page_2.xml').read
        )
    # Valid arameters and valid response, second page
    stub_request(:get, /example.com/)
        .with(:query => {'q' => 'dmQuery/all/0/dmrecord/dmrecord/1024/21/1/0/0/0/0/0/xml'})
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + '/fixtures/search/response_page_last.xml').read
        )
    stub_request(:get, /example.com/)
        .with(:query => {'q' => 'dmQuery/single/0/dmrecord/dmrecord/1024/1/1/0/0/0/0/0/xml'})
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + '/fixtures/search/response_single_page.xml').read
        )
  end
end
describe 'ContentDM Search Results from a dmQuery' do
  describe 'Returns expected values parsed from response' do

    before(:each) do
      @query = CDM::Api::SearchQuery.new :url => 'http://example.com'
    end

    subject { CDM::Api::SearchResults.new :result => @query.results, :query => @query }

    context 'Paging section of response' do

      it 'exposes the correct total number of records' do
        expect(subject.total).to eq 25
      end

      it 'exposes the correct limit of records per page' do
        expect(subject.records_per_page).to be 10
      end

      it 'exposes the correct record number the results start at' do
        expect(subject.start).to be 1
      end
    end

    context 'Results section of response' do

      it 'exposes a list of records' do
        expect(subject.records).to respond_to :each
      end

      it 'has the expected number of records' do
        expect(subject.records.count).to be 10
      end
    end

    context 'the individual response' do

      let(:first) { subject.records.first }
      let(:last)  { subject.records.last }

      it 'provides its id via the record method' do
        expect(first.id).to eql '3089'
        expect(last.id).to eql '785'
      end
    end

    context 'The next page method' do


      it 'updates the value of start' do
        results = CDM::Api::SearchResults.new(:result => @query.results, :query => @query).next_page!
        expect(results.start).to be 11
      end

      it 'updates the records returned' do
        results = CDM::Api::SearchResults.new(:result => @query.results, :query => @query).next_page!
        expect(results.records.first.id).to eql '3200'
        expect(results.records.last.id).to eql '785'

      end
    end

    context 'The `is_last_page?` method' do
      it 'returns false for pages that re not the first page' do
        expect(subject.is_last_page?).to be false
      end

      it 'returns true for the actual last page of results' do
        last_page_query = @query.dup
        last_page_query.start = 21
        result = CDM::Api::SearchResults.new :result => last_page_query.results, :query => last_page_query
        expect(result.is_last_page?).to be true
      end
    end

    context '#all method' do

      it 'iterates through all records in a multipage result' do
        expect(subject.all.map.count).to be 25
      end

      it 'has the expected items' do
        res = subject.all.map { |x| x }
        expect(res.first.id).to eql '3089'
        expect(res.last.id).to eql '17'
      end

      it 'iterates through all items in a single page result' do
        query = CDM::Api::SearchQuery.new :url => 'http://example.com', :alias => 'single'
        result = CDM::Api::SearchResults.new :result => query.results, :query => query
        expect(result.all.map.count).to be 9
      end

    end

  end
end