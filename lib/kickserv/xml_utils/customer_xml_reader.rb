# frozen_string_literal: true

require File.expand_path('../xml_utils/xml_reader', __dir__)

module Kickserv
  # Customer specific XmlReader used to encapsulate as much as possible of the resulting XML parsing
  # It utilizes a Nokogiri Nodeset to read the XML and convert to customers hash
  class CustomerXmlReader < XmlReader
    # @return [Array] of hashes as defined in parse_customers
    # This makes up half of the public interface, allowing access to a list of customers
    def customers
      xml_doc = Nokogiri::XML(@xml_string)
      parse_customers(xml_doc)
    end

    def customer
      xml_doc = Nokogiri::XML(@xml_string)
      parse_customer(xml_doc)
    end

    private

    # @return [Array] of Hashes
    # @param xml_doc [Nokogiri::XML] Nokogiri XML nodeset
    # parses the needed areas of the XML nodeset and jobs that information into
    # an array of hashes each representing a customer.
    def parse_customers(xml_doc)
      # handle array of customer data
      customers = xml_doc.css('customers customer').map do |node|
        # create a customer HASH from the XML node of type customer
        child_fields_values(node)
      end
    end

    # @return [Array] of Hashes
    # @param xml_doc [Nokogiri::XML] Nokogiri XML nodeset
    # parses the needed areas of the XML nodeset and jobs that information into
    # an array of hashes each representing a customer.
    def parse_customer(xml_doc)
      customer = {}
      attribute_names = get_attributes
      # handle single node of customer data
      if customers.empty?
        node = xml_doc.css('customers')
        # create a customer HASH from the XML node of type customer
        customer = child_fields_values(node)
      end
      customer
    end
  end
end
