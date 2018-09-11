# frozen_string_literal: true

require 'faraday_middleware'

Dir[File.expand_path('../faraday/*.rb', __dir__)].each { |f| require f }

module Kickserv
  module HttpUtils
    # Kickserv API connection implementation
    module Connection
      def get_url
        "https://#{endpoint}#{api_version}/#{account_slug}/"
      end

      private

      def connection(url = nil)
        options = {
          url: get_url
        }

        options[:url] = url unless url.nil?

        Faraday::Connection.new(options) do |connection|
          connection.use Faraday::Request::BasicAuthentication, api_key, api_key
          connection.use FaradayMiddleware::Mashify
          connection.adapter(adapter)
        end
      end
    end
  end
end
