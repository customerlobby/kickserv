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
      xml_doc = Nokogiri::XML(xml_string)
      @customers = parse_customers(xml_doc)
      raise Kickserv::Error::NoDataFoundError.new, 'No data found.' if @customers.empty?
    end

    private

    # @return [Array] of Hashes
    # @param xml_doc [Nokogiri::XML] Nokogiri XML nodeset
    # parses the needed areas of the XML nodeset and jobs that information into
    # an array of hashes each representing a customer.
    def parse_customers(xml_doc)
      attribute_names = %w(id name first-name last-name email phone alt-phone-number
                          alt-phone mobile billing-address billing-address-2
                          billing-city billing-state billing-country
                          billing-zip-code service-address service-address-2
                          service-city service-state service-country
                          service-zip-code which-billing-address is-active
                          company company-name customer-type-ref-full-name
                          terms-ref-full-name sales-rep-ref-full-name
                          balance total-balance customer-type-id
                          send-reminders notification-email-address
                          notify-via-email send-notifications customer-number)
      xml_doc.css('customers customer').map do |node|
        # create a customer HASH from the XML node of type customer
        customer = Hash.new
        attribute_names.each do |attr|
          value = get_value(node, attr)
          customer[attr] = value if not value.nil?
        end
        customer
      end
    end
  end
end

