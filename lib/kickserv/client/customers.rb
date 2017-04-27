module Kickserv
  class Client
    module Customers
      def customers(params={})
        XmlReader.new(get('customers.xml', params)).customers
      end
    end
  end
end
