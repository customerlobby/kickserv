require File.expand_path('../../errors/authorization_error', __FILE__)
require File.expand_path('../../errors/connection_error', __FILE__)
require File.expand_path('../../http_utils/response', __FILE__)

module Kickserv
  module HttpUtils
    # Kickserv HTTP API Request Handler implementation
    module Request
      # Perform an HTTP GET request
      def get(path, options = {})
        formatted_options = format_options(options)
        request(:get, path, formatted_options)
      end

      # Perform an HTTP POST request
      def post(path, options = {})
        request(:post, path, options)
      end

      private

      # Perform an HTTP request
      def request(method, path, options)
        begin
          response = connection.send(method) do |request|
            case method
              when :get
                formatted_options = format_options(options)
                request.url(path, formatted_options)
              when :post, :put
                request.headers['Content-Type'] = 'application/json'
                request.body = options.to_json unless options.empty?
                request.url(path)
            end
            request.options.timeout = 120 # read timeout
            request.options.open_timeout = 300 # connection timeout
          end
        rescue
          # handle connection related failures and raise gem specific standard error
          raise ConnectionError.new, 'Connection failed.'
        end
        # check if the status code is 401
        if response.status == 200
          Response.create(response.body)
        elsif response.status == 401
          raise AuthorizationError.new, 'Invalid credentials.'
        else
          raise StandardError.new, "Kickserv API Failed, status code: #{response.status}"
        end
      end

      # Format the Options before you send them off to Kickserv
      def format_options(options)
        return if options.blank?
        opts = {}
        options.each do |key, value|
          if key == :page
            opts[:page] = options[:page] if options.has_key?(:page)
          elsif key == :only
            opts[:only] = format_fields(options[:only]) if options.has_key?(:only)
          elsif key == :include
            opts[:include] = format_fields(options[:include]) if options.has_key?(:include)
          else
            opts[key] = options[key]
          end
        end
        opts
      end

      # Format the fields to a format that the Kickserv likes
      # @param [Array or String] fields can be specified as an Array or String
      # @return String
      def format_fields(fields)
        if fields.instance_of?(Array)
          return fields.join(",")
        else
          return fields.to_s
        end
      end

    end
  end
end