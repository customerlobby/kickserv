require File.expand_path('../../xml_utils/xml_reader', __FILE__)

module Kickserv
  # Customer specific XmlReader used to encapsulate as much as possible of the resulting XML parsing
  # It utilizes a Nokogiri Nodeset to read the XML and convert to customers hash
  class CustomerXmlReader < XmlReader

    # @return [Array] of hashes as defined in parse_customers
    # This makes up half of the public interface, allowing access to a list of customers
    def customers
      @customers
    end

    # @return nil
    # @param xml_string [String] Xml string from Kickserv API response.body
    def parse_xml(xml_string)
      xml_doc    = Nokogiri::XML(xml_string)
      @customers = parse_customers(xml_doc)
    end

    private

    # @return [Array] of Hashes
    # @param xml_doc [Nokogiri::XML] Nokogiri XML nodeset
    # parses the needed areas of the XML nodeset and jobs that information into
    # an array of hashes each representing a customer.
    def parse_customers(xml_doc)
      xml_doc.css('customers customer').map do |node|
        # create a customer HASH from the XML node of type customer
        {
            'id' => get_value(node, 'id'),
            'name' => get_value(node, 'name'),
            'first-name' => get_value(node, 'first-name'),
            'last-name' => get_value(node, 'last-name'),
            'email' => get_value(node, 'email'),
            'phone' => get_value(node, 'phone'),
            'alt-phone-number' => get_value(node, 'alt-phone-number'),
            'alt-phone' => get_value(node, 'alt-phone'),
            'mobile' => get_value(node, 'mobile'),
            'billing-address' => get_value(node, 'billing-address'),
            'billing-address-2' => get_value(node, 'billing-address-2'),
            'billing-city' => get_value(node, 'billing-city'),
            'billing-state' => get_value(node, 'billing-state'),
            'billing-country' => get_value(node, 'billing-country'),
            'billing-zip-code' => get_value(node, 'billing-zip-code'),
            'service-address' => get_value(node, 'service-address'),
            'service-address-2' => get_value(node, 'service-address-2'),
            'service-city' => get_value(node, 'service-city'),
            'service-state' => get_value(node, 'service-state'),
            'service-country' => get_value(node, 'service-country'),
            'service-zip-code' => get_value(node, 'service-zip-code'),
            'which-billing-address' => get_value(node, 'which-billing-address'),
            'is-active' => get_value(node, 'is-active'),
            'company' => get_value(node, 'company'),
            'company-name' => get_value(node, 'company-name'),
            'customer-type-ref-full-name' => get_value(node, 'customer-type-ref-full-name'),
            'terms-ref-full-name' => get_value(node, 'terms-ref-full-name'),
            'sales-rep-ref-full-name' => get_value(node, 'sales-rep-ref-full-name'),
            'balance' => get_value(node, 'balance'),
            'total-balance' => get_value(node, 'total-balance'),
            'customer-type-id' => get_value(node, 'customer-type-id'),
            'send-reminders' => get_value(node, 'send-reminders'),
            'notification-email-address' => get_value(node, 'notification-email-address'),
            'notify-via-email' => get_value(node, 'notify-via-email'),
            'send-notifications' => get_value(node, 'send-notifications')
        }
      end
    end
  end
end

