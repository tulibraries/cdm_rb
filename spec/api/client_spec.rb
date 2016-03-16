require 'spec_helper'

describe 'Base ContentDM API class' do
  context "Valid parameters" do

    it 'builds a valid url when passed just a backend_url' do
      client = CDM::Api::Client.new :url => "http://example.com"
      expect(client.base_url).to eq "http://example.com/dmwebservices/index.php?q="
    end

    it 'builds a valid url when passed a backend_url and port' do
      client = CDM::Api::Client.new(:url => "http://example.com", :port => 81)
      expect(client.base_url).to eq "http://example.com:81/dmwebservices/index.php?q="
    end

    it 'builds a valid url when passed a backend_url and frontend_url ' do
      client = CDM::Api::Client.new({
                                   :url => "http://backend.com",
                               })
      expect(client.base_url).to eq "http://backend.com/dmwebservices/index.php?q="
    end
  end
end

