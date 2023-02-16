# frozen_string_literal: true

require File.expand_path('../xml_utils/xml_reader', __dir__)

require File.expand_path('../errors/no_data_found_error', __dir__)

module Kickserv
  # Job entity specific XmlReader used to encapsulate as much as possible of the resulting XML parsing
  # It utilizes a Nokogiri Nodeset to read the XML and convert to hash jobs
  class JobXmlReader < XmlReader
    # @return [Array] of hashes as defined in parse_jobs
    # This makes up half of the public interface, allowing access to a list of customers
    def jobs
      xml_doc = Nokogiri::XML(@xml_string)
      parse_jobs(xml_doc)
    end

    # @return hash as defined in parse_job
    # This makes up half of the public interface, allowing access to a list of customers
    def job
      xml_doc = Nokogiri::XML(@xml_string)
      parse_job(xml_doc)
    end

    private

    # @return [Array] of hashes representing jobs
    # @param xml_doc [NodeSet] Nokogiri XML nodeset
    # Parses the jobs information from the NodeSet and organizes it into an array of hashes
    def parse_jobs(xml_doc)
      # handle array of job data
      xml_doc.css('jobs job').map do |node|
        child_fields_values(node)
      end
    end

    def parse_job(xml_doc)
      attribute_names = get_attributes
      # handle single job data
      if jobs.empty?
        node = xml_doc.css('job')
        unless node.nil?
          # create a job HASH from the XML node of type job
          job = child_fields_values(node)
        end
      end
      job
    end
  end
end
