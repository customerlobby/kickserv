require File.expand_path('../../xml_utils/customer_xml_reader', __FILE__)
require File.expand_path('../../http_utils/request', __FILE__)

module Kickserv
  module Models
    # Kickserv Customer model specific implementation
    module Customer
      # include module http_utils to call kickserv apis to fetch data
      include HttpUtils::Request

      def customers(params = {})
        # Get all the customers data from kickserv APIs and return
        CustomerXmlReader.new(get('customers.xml', params)).customers
      end
    end
  end
end
