# frozen_string_literal: true

module Kickserv
  module HttpUtils
    # Kickserv HTTP API Response Handler Implementation
    module Response
      def self.create(response_hash)
        data = begin
                 response_hash.data.dup
               rescue StandardError
                 response_hash
               end
        data.extend(self)
        data
      end

      attr_reader :pagination
      attr_reader :meta
    end
  end
end
