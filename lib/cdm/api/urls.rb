module CDM
  module Api
    module Urls

      def construct_backend_url(url, port=nil)
        port = make_portly port
        "#{url + port.to_s}/dmwebservices/index.php?q="
      end

      def make_portly(port_arg)
        ":#{port_arg}" if port_arg
      end
    end
  end

end