require 'bigdecimal'
require 'nokogiri'

module Kickserv
  # XmlReader is used to encapsulate as much as possible of the resulting XML parsing
  # It utilizes a Nokogiri Nodeset to read the XML and convert to 2 arrays of hashes (customers, jobs)
  class XmlReader
    # @return [XmlReader] with the xml_string parsed into instance variables
    # @param xml_string [String] Xml String with the structure provided by the Kickserv API
    def initialize(xml_string)
      parse_xml(xml_string)
    end

    # @return [Array] of hashes as defined in parse_customers
    # This makes up half of the public interface, allowing access to a list of customers
    def customers
      @customers
    end

    # @return [Array] of hashes as defined in parse_jobs
    # This makes up half of the public interface, allowing access to a list of jobs
    def jobs
      @jobs
    end

    private

    # @return nil
    # @param xml_string [String] Xml string from Kickserv API response.body
    def parse_xml(xml_string)
      xml_doc    = Nokogiri::XML(xml_string)
      @customers = parse_customers(xml_doc)
      @jobs      = parse_jobs(xml_doc)
    end

    # @return [Array] of Hashes
    # @param xml_doc [Nokogiri::XML] Nokogiri XML nodeset
    # parses the needed areas of the XML nodeset and jobs that information into an array of hashes
    # each representing a customer.
    def parse_customers(xml_doc)
      xml_doc.css('customers customer').map do |node|
        {
          external_id: get_value(node, 'id'),
          name: get_value(node, 'name'),
          first_name: get_value(node, 'first-name'),
          last_name: get_value(node, 'last-name'),
          email: get_value(node, 'email-address') || get_value(node, 'email'),
          phone: get_value(node, 'phone-number') || get_value(node, 'phone'),
          mobile_phone: get_value(node, 'mobile'),
          alt_phone: get_value(node, 'alt-phone') || get_value(node, 'alt-phone-number'),
          address1: get_value(node, 'service-address') || get_value(node, 'billing-address'),
          address2: get_value(node, 'service-address-2') || get_value(node, 'billing-address-2'),
          city: get_value(node, 'service-city') || get_value(node, 'billing-city'),
          state: get_value(node, 'service-state') || get_value(node, 'billing-state'),
          zip: get_value(node, 'service-zip-code') || get_value(node, 'billing-zip-code'),
          is_active: get_value(node, 'is-active'),
          is_company: get_value(node, 'company'),
          company_name: get_value(node, 'company-name'),
        }
      end
    end

    # @return [Array] of hashes representing jobs
    # @param xml_doc [NodeSet] Nokogiri XML nodeset
    # Parses the jobs information from the NodeSet and organizes it into an array of hashes
    def parse_jobs(xml_doc)
      xml_doc.css('jobs job').map do |node|
        {
          external_id: get_value(node, 'id'),
          external_customer_id: get_value(node, 'customer-id'),
          amount: get_value(node, 'total'),
          subtotal: get_value(node, 'subtotal'),
          balance: get_value(node, 'balance-remaining'),
          transacted_at: get_value(node, 'created-at'),
          due_date: get_value(node, 'scheduled-on'),
        }
      end
    end

    # @return [String]
    # @param node [Nokogiri::Node] Node to check the value of
    # @param field_name [String] field in the node we're interested in
    # Helper function that takes a node and field name, returning the value of the field or nil
    def get_value(node, field_name)
      value = node.at_css(field_name)
      return nil if value.nil? or value.text.empty?
      value.text
    end

 end
end
