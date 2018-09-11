# frozen_string_literal: true

require File.expand_path('../xml_utils/customer_xml_reader', __dir__)
require File.expand_path('../http_utils/request', __dir__)

module Kickserv
  module Models
    # Kickserv Customer model specific implementation
    module Customer
      # include module http_utils to call kickserv apis to fetch data
      include HttpUtils::Request

      # Added method to get customers data with different filters.
      def customers(params = {})
        # Get all the customers data from kickserv APIs and return
        CustomerXmlReader.new(get(path: 'customers.xml', params: params)).customers
      end

      # Added method to filter customer based on customer-number.
      def customer(customer_number)
        CustomerXmlReader.new(get(url: get_url + 'customers/',
                                  path: "#{customer_number}.xml")).customer
      end
   end
  end
end
