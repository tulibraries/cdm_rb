require 'spec_helper'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /example.com/)
        .to_return(status: 200, body: File.open(File.dirname(__FILE__) + "/fixtures/collection_response.xml").read , headers: {})
  end
end

describe 'ContentDM Collections Query' do
  context "return values" do
    before do
      @collections = CDM::Api::Collections.new :url => "http://example.com"
    end

    it '' do

    end


  end
end

