# frozen_string_literal: true

module CDM
  class << self
    attr_accessor :configuration
  end

  def self.configure()
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :server_url, :server_port, :format
    attr_accessor :max_recs, :enable_loggable

    def initialize
      @enable_loggable = false
    end
  end
end
