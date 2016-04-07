  #setup the webmock queries
  RSpec.configure do |config|
    config.before(:each) do

      stub_request(:get, /example.com/)
          .with(:query => {'q' => 'dmGetItemInfo/p16002coll9/1314/xml'})
          .to_return(
              status: 200,
              body: File.open(SPEC_ROOT + '/fixtures/item_info/response.xml').read ,
          )

      stub_request(:get, /example.com/).with(:query => {'q' => 'dmGetItemInfo/p16002coll9/INVALID_ID/xml'})
          .to_return(
              status: 200,
              body: File.open(SPEC_ROOT + '/fixtures/item_info/invalid_item_id.xml').read ,
          )

      stub_request(:get, /example.com/).with(:query => {'q' => 'dmGetItemInfo/INVALID_COLLECTION_ID/1314/xml'})
          .to_return(
              status: 200,
              body: File.open(SPEC_ROOT + '/fixtures/item_info/invalid_collection_id.xml').read ,
          )
    end
  end
  describe 'ContentDM Item Info Query' do

  describe 'Returns representations of single item' do
    before do
      @item = CDM::Api::ItemInfo.new :url => 'http://example.com', :collection => 'p16002coll9', :id => '1314'
    end
    context 'raw method' do
      before do
        @raw = @item.raw

      end
      it 'returns the raw xml for a single item' do
        expect(@raw).to be_a String
      end

      it 'returns the raw xml for a single item' do
        expect(@raw).to include '<title>3 questions to employers</title>'
      end
    end

    context 'parsed method' do
      it 'returns a Nokogiri object' do
        expect(@item.parsed).to be_a Nokogiri::XML::Document
      end
    end

    context 'hash method' do
      before do
        @hash = @item.to_h
      end
      it 'returns a hash of the records fields' do
        expect(@hash).to be_a Hash
      end

      it 'has expected keys' do
        expect(@hash.keys).to include 'reposa', 'title', 'ada', 'cdmisnewspaper'
      end

      context 'has expected values for fields' do
        it 'has expected values for fields with data' do
          expect(@hash['title']).to eql '3 questions to employers'
        end

        it 'has anb empty value for empty fields' do
          expect(@hash['dmaccess']).to eql ''
        end

        it 'handles dates as strings' do
          expect(@hash['dmmodified']).to eql '2012-09-11'
        end

        it 'handles integers as strings' do
          expect(@hash['cdmisnewspaper']).to eql '0'
        end
      end
    end
  end
  context 'handles invalid item ID gracefully' do

    it 'raises an exception if no item with that id exists' do
      expect {
        CDM::Api::ItemInfo.new :url => 'http://example.com', :collection => 'p16002coll9', :id => 'INVALID_ID'
      }.to raise_error ArgumentError
    end
  end
end

