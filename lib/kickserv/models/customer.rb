require File.expand_path('../../xml_utils/customer_xml_reader', __FILE__)
require File.expand_path('../../http_utils/request', __FILE__)

module Kickserv
  module Models
    # Kickserv Customer model specific implementation
    module Customer
      # include module http_utils to call kickserv apis to fetch data
      include HttpUtils::Request

      def customers(params = {})
        if params.has_key?(:customer_number)
          return CustomerXmlReader.new(get(url: get_url + 'customers/',
                                           path: "#{params[:customer_number]}.xml")).customers
        else
          # Get all the customers data from kickserv APIs and return
          return CustomerXmlReader.new(get(path: 'customers.xml', params: params)).customers
        end
      end
    end
  end
end