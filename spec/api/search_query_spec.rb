require 'rspec'

RSpec.configure do |config|
  config.before(:each) do

    # Valid arameters and valid response
    stub_request(:get, /example.com*dmQuery/)
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + '/fixtures/search/response.xml').read ,
            headers: {}
        )
  end
end

describe 'ContentDM Search endpoint (dmQuery)' do
  context 'query string method' do

    let(:base) { 'http://example.com/dmwebservices/index.php?q=dmQuery'}

    it 'returns the default search string when no params are passed' do
      results = CDM::Api::SearchQuery.new :url => 'http://example.com'
      expect(results.query_string).to eql base + '/all/0/dmrecord/dmrecord/1024/1/1/0/0/0/0/0/xml'
    end

    it 'correctly handles collection aliases' do
      results = CDM::Api::SearchQuery.new :url => 'http://example.com', :alias => 'test_alias'
      expect(results.query_string).to eql base + '/test_alias/0/dmrecord/dmrecord/1024/1/1/0/0/0/0/0/xml'
    end
  end
end