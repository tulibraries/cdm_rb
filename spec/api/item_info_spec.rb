require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /dmwebservices\/index\.php\?q=dmGetItemInfo/)
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + '/fixtures/item_info_response.xml').read ,
            headers: {}
        )
  end
end

describe 'ContentDM Item Info Query' do
  describe 'Returns representations of single item' do
    before do
      @item = CDM::Api::ItemInfo.new :url => 'http://example.com', :collection => 'p16002coll9', :id => '1314'
    end

    context 'raw method' do
      it 'returns the raw xml for a single item' do
        expect(@item.raw).to be_a String
      end

      it 'returns the raw xml for a single item' do
        expect(@item.raw).to include '<title>3 questions to employers</title>'
      end
    end

    context 'parsed method' do
      it 'returns a Nokogiri object' do
        expect(@item.parsed).to be_a Nokogiri::XML::Document
      end
    end

    context 'hash method' do
      it 'returns a hash of the records fields' do
        expect(@item.to_h).to be_a Hash
      end

      it 'has expected keys' do
        expect(@item.to_h.keys).to include 'reposa', 'title'
      end
    end

  end
end

