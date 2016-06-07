#setup the webmock queries
RSpec.configure do |config|
  config.before(:each) do

    stub_request(:get, /example.com/)
        .with(:query => {'q' => 'dmGetCompoundObjectInfo/p245801coll12/39557/xml'})
        .to_return(
            status: 200,
            body: File.open(SPEC_ROOT + '/fixtures/compound_object_info/with_sections.xml').read ,
        )
  end
end
describe 'ContentDM Compound Object Info Query' do
  before do
    @compound = CDM::Api::CompoundObjectInfo.new :url => 'http://example.com', :collection => 'p245801coll12', :id => '39557'
  end
  context 'sections method' do

    it 'returns the an array of items' do
      expect(@compound.sections).to be_an Array
    end

    it 'returns strings as array values' do
      expect(@compound.sections.first).to be_a String
    end
  end

  context 'pages method' do
    it 'returns an array of items' do
      expect(@compound.pages).to be_an Array
    end

    it 'returns hashes as array items' do
      expect(@compound.pages.first).to be_a Hash
    end


  end

end