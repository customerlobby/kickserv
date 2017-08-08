require File.expand_path('../../xml_utils/customer_xml_reader', __FILE__)
require File.expand_path('../../http_utils/request', __FILE__)
require File.expand_path('../../http_utils/page', __FILE__)

module Kickserv
  module Models
    # Kickserv Customer model specific implementation
    module Customer
      # include module http_utils to call kickserv apis to fetch data
      include HttpUtils::Request
      include HttpUtils::Page

      def customers(params = {})
        if params.has_key?(:customer_number)
          customers = CustomerXmlReader.new(get(url: get_url + 'customers/',
                                                path: "#{params[:customer_number]}.xml")).customers
        else
          # Get all the customers data from kickserv APIs and return
          customers = CustomerXmlReader.new(get(path: 'customers.xml', params: params)).customers
          p "SIZE: #{customers.size}, #{customers.empty?} #{customers.nil?}"
          if (customers.nil? || customers.empty?) && (params.has_key?('page') || params.has_key?(:page))
            page_count = calculate_page_count('customers', params, start_index = 1, end_index = params[:page])
            raise Kickserv::Error::NoDataFoundError.new, "There are only #{page_count} data pages."
          end
        end
        customers
      end
    end
  end
end