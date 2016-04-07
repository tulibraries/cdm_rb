
RSpec.configure do |config|
  config.before(:each) do
    # Valid parameters and valid response

    stub_request(:get, /example.com/)
        .with(:query => {'q' => 'dmQuery/all/0/dmrecord/dmrecord/1024/1/1/0/0/0/0/0/xml' })
        .to_return(
            :status => 200,
            :body => "",
            :headers => {}
        )
  end
end

describe 'ContentDM Search endpoint (dmQuery)' do

  before(:each) do
    @query = CDM::Api::SearchQuery.new :url => 'http://example.com'
    @base = 'http://example.com/dmwebservices/index.php?q=dmQuery'
  end

  context 'query string method' do
    it 'returns the default search string when no params are passed' do
      expect(@query.query_string).to eql @base + '/all/0/dmrecord/dmrecord/1024/1/1/0/0/0/0/0/xml'
    end

    it 'correctly handles collection aliases' do
      query = CDM::Api::SearchQuery.new :url => 'http://example.com', :alias => 'test_alias'
      expect(query.query_string).to eql @base + '/test_alias/0/dmrecord/dmrecord/1024/1/1/0/0/0/0/0/xml'
    end
  end

  context 'results method' do
    it 'returns expected results' do
      expect(@query.results).to be_a Nokogiri::XML::Document
    end
  end
end