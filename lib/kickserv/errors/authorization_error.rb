# frozen_string_literal: true

# custom error for authorization related failures
module Kickserv
  module Error
    class AuthorizationError < StandardError
    end
  end
end
