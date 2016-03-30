require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /example.com/)
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
      @item_info = CDM::Api::ItemInfo.new :url => 'http://example.com', :collection => 'p16002coll9', :id => '1314'
    end

    context 'list method' do
      it 'returns a list of collections' do
        expect(@collections.list).to be_an Array
      end
    end
  end
end

