RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /example.com/)
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + "/fixtures/collections_response.xml").read ,
            headers: {}
        )
  end
end

describe 'ContentDM Collections Query' do
  describe "Returns expected representations" do
    before do
      @collections = CDM::Api::Collections.new :url => "http://example.com"
    end

    context 'list method' do
      it 'returns a list of collections' do
        expect(@collections.list).to be_an Array
      end

      it 'includes all collections' do
        expect(@collections.list.count).to eql 32
      end

      it 'has hashes for members' do
        expect(@collections.list.first).to be_a Hash
      end

      it 'members contain only the alias and name of a single collection' do
        expect(@collections.list.first.keys).to contain_exactly 'p16002coll9'
        expect(@collections.list.first.values).to contain_exactly 'Allied Posters of World War I'
      end
    end

    context 'to hash method' do

      it 'returns a hash' do
        expect(@collections.to_h).to be_a Hash
      end

      it 'contains entries all collections' do
        expect(@collections.to_h.count).to eql 32
      end

      it 'has an expected key' do
        expect(@collections.to_h.key? 'p16002coll9').to be
      end

      it 'to have the correct name for each collection' do
        expect(@collections.to_h['p16002coll9']).to eql 'Allied Posters of World War I'
      end
    end

    context 'parsed method' do
      it 'returns a nokigiri object' do
        expect(@collections.parsed).to be_a Nokogiri::XML::Document
      end

    end



  end
end

