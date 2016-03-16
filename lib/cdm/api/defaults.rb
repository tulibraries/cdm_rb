module CDM
  module Api
    module Defaults
      def self.set_format(format)
        format || 'xml'
      end
    end
  end
end