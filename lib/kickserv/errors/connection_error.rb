# custom error for connection related failures, like no internet connection
module Kickserv
  module Error
    class ConnectionError < StandardError
    end
  end
end