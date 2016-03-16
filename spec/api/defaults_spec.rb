require 'rspec'

describe 'Set Default values' do
  before(:all) do
    @defaults = Class.new
    @defaults.extend(CDM::Api::Defaults)
  end

  describe "format" do
    it 'returns xml if not format is specified' do
      expect(@defaults.set_format).to eq "xml"
    end


  end

end