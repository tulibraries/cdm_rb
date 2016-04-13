
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

    before(:all) do
      @query = CDM::Api::SearchQuery.new :url => 'http://example.com'
    end

    subject { CDM::Api::SearchResults.new :result => @query.results, :query => @query }

    context 'Paging section of response' do

      it 'exposes the correct total number of records' do
        expect(subject.total).to eq 500
      end

      it 'exposes the correct limit of records per page' do
        expect(subject.records_per_page).to be 10
      end

      it 'exposes the correct record number the results start at' do
        expect(subject.start).to be 0
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
        expect(CDM::Api::SearchResults.record_id first).to eql '3089'
        expect(CDM::Api::SearchResults.record_id last).to eql '785'
      end
    end

    context 'The next page method' do

      it 'updates the value of start' do

      end
    end

  end
end