require File.expand_path('../../xml_utils/xml_reader', __FILE__)

module Kickserv
  # Job entity specific XmlReader used to encapsulate as much as possible of the resulting XML parsing
  # It utilizes a Nokogiri Nodeset to read the XML and convert to hash jobs
  class JobXmlReader < XmlReader

    # @return [Array] of hashes as defined in parse_customers
    # This makes up half of the public interface, allowing access to a list of customers
    def jobs
      @jobs
    end

    # @return nil
    # @param xml_string [String] Xml string from Kickserv API response.body
    def parse_xml(xml_string)
      xml_doc = Nokogiri::XML(xml_string)
      @jobs = parse_jobs(xml_doc)
    end

    private

    # @return [Array] of hashes representing jobs
    # @param xml_doc [NodeSet] Nokogiri XML nodeset
    # Parses the jobs information from the NodeSet and organizes it into an array of hashes
    def parse_jobs(xml_doc)
      attribute_names = %w(id customer-id total subtotal balance-remaining
                        created-at scheduled-on started-on completed-on name txn-id
                        recurring-job-id job-type-id job-status-id duration invoice-terms
                        invoice-notes estimate-terms estimate-notes description
                        status invoice-status invoice-date invoice-paid-on
                        notification-sent total-expenses job-number)
      xml_doc.css('jobs job').map do |node|
        # create a job HASH from the XML node of type job
        job = Hash.new
        attribute_names.each do |attr|
          value = get_value(node, attr)
          job[attr] = value if not value.nil?
        end
        job
      end
    end
  end
end

