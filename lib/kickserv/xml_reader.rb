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
    end

    # @return [Array] of hashes representing jobs
    # @param xml_doc [NodeSet] Nokogiri XML nodeset
    # Parses the jobs information from the NodeSet and organizes it into an array of hashes
    def parse_jobs(xml_doc)
    end

  end
end
