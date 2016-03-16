module CDM
  module Api
    module Defaults
      def set_format(format=nil)
        format ||= 'xml'
      end
    end
  end
end