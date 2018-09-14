# frozen_string_literal: true

# custom error if not data found in the response.
module Kickserv
  module Error
    class NoDataFoundError < StandardError
    end
  end
end
