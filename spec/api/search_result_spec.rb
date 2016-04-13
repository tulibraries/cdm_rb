
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
  end
end
describe 'ContentDM Search Results from a dmQuery' do
  describe 'Returns expected values parsed from response' do
    before do
      @query = CDM::Api::SearchQuery.new :url => 'http://example.com'
    end

    it 'exposes the correct total number of records' do
      @result = CDM::Api::SearchResult.new :result => @query.results, :query => @query
      expect(@result.total).to eq 500
    end

    it 'exposes the correct limit of records per page' do
      @result = CDM::Api::SearchResult.new :result => @query.results, :query => @query
      expect(@result.records_per_page).to be 10
    end

    it 'exposes the correct record number the results start at' do
      @result = CDM::Api::SearchResult.new :result => @query.results, :query => @query
      expect(@result.start).to be 0

    end
  end
end