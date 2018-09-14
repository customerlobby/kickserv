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
      attribute_names = get_attributes
      # handle array of job data
      jobs = xml_doc.css('jobs job').map do |node|
        # create a job HASH from the XML node of type job
        job = {}
        attribute_names.each do |attr|
          value = get_value(node, attr)
          job[attr] = value
        end
        job
      end
      jobs
    end

    def parse_job(xml_doc)
      attribute_names = get_attributes
      # handle single job data
      if jobs.empty?
        node = xml_doc.css('job')
        unless node.nil?
          # create a job HASH from the XML node of type job
          job = {}
          attribute_names.each do |attr|
            value = get_value(node, attr)
            job[attr] = value
          end
        end
      end
      job
    end

    def get_attributes
      %w[id customer-id total subtotal balance-remaining
         created-at scheduled-on started-on completed-on name txn-id
         recurring-job-id job-type-id job-status-id duration invoice-terms
         invoice-notes estimate-terms estimate-notes description
         status invoice-status invoice-date invoice-paid-on
         notification-sent total-expenses job-number]
    end
  end
end
