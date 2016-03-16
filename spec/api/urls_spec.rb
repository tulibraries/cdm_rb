require 'rspec'

describe 'urls utilities' do
  before(:all) do
    @urls = Class.new
    @urls.extend(CDM::Api::Urls)
  end

  describe 'construct_backend_url' do

    it 'can accept just a url' do
      base_url = @urls.construct_backend_url "http://example.com"
      expect(base_url).to eq("http://example.com/dmwebservices/index.php?q=")
    end

    it 'can accept url and port' do
      base_url = @urls.construct_backend_url "http://example.com", "81"
      expect(base_url).to eq("http://example.com:81/dmwebservices/index.php?q=")
    end

  end

end