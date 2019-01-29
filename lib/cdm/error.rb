# frozen_string_literal: true

module CDM
  class StandardError < ::StandardError
    def initialize(message, loggable = {})
      if CDM.configuration&.enable_loggable
        message = { error: message }.merge(loggable).to_json
      end

      super message
    end
  end
end
