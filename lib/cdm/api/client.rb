

module CDM
  module Api
    class Client

      include CDM::Api::Urls
      include CDM::Api::Defaults

      attr_reader :base_url

      def initialize(args)
        @base_url = construct_backend_url args.fetch(:url), args.fetch(:port, nil)
      end



    end
  end
end