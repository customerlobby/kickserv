# frozen_string_literal: true

require 'bigdecimal'
require 'nokogiri'

module Kickserv
  # XmlReader is used to encapsulate as much as possible of the resulting XML parsing
  # It utilizes a Nokogiri Nodeset to read the XML and convert to 2 arrays of hashes (customers, jobs)
  class XmlReader
    @xml_string
    # @return [XmlReader] with the xml_string parsed into instance variables
    # @param xml_string [String] Xml String with the structure provided by the Kickserv API
    def initialize(xml_string)
      @xml_string = xml_string
    end

    private

    # @return [String]
    # @param node [Nokogiri::Node] Node to check the value of
    # @param field_name [String] field in the node we're interested in
    # Helper function that takes a node and field name, returning the value of the field or nil
    def get_value(node, field_name)
      value = node.at_css(field_name)
      return nil if value.nil? || value.text.empty?
      value.text
    end
  end
end
