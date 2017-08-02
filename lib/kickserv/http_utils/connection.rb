require 'faraday_middleware'

Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Kickserv
  module HttpUtils
    # Kickserv API connection implementation
    module Connection

      private

      def connection
        options = {
            :url => "https://#{subdomain}.#{endpoint}#{api_version}/"
        }

        Faraday::Connection.new(options) do |connection|
          connection.use Faraday::Request::BasicAuthentication, api_key, api_key
          connection.use FaradayMiddleware::Mashify
          connection.adapter(adapter)
        end
      end
    end
  end
end
