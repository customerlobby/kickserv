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
      xml_doc.css('jobs job').map do |node|
        # create a job HASH from the XML node of type job
        {
            'id' => get_value(node, 'id'),
            'customer-id' => get_value(node, 'customer-id'),
            'total' => get_value(node, 'total'),
            'subtotal' => get_value(node, 'subtotal'),
            'balance-remaining' => get_value(node, 'balance-remaining'),
            'created-at' => get_value(node, 'created-at'),
            'scheduled-on' => get_value(node, 'scheduled-on'),
            'started-on' => get_value(node, 'started-on'),
            'completed-on' => get_value(node, 'completed-on'),
            'name' => get_value(node, 'name'),
            'txn-id' => get_value(node, 'txn-id'),
            'recurring-job-id' => get_value(node, 'recurring-job-id'),
            'job-type-id' => get_value(node, 'job-type-id'),
            'job-status-id' => get_value(node, 'job-status-id'),
            'duration' => get_value(node, 'duration'),
            'invoice-terms' => get_value(node, 'invoice-terms'),
            'invoice-notes' => get_value(node, 'invoice-notes'),
            'estimate-terms' => get_value(node, 'estimate-terms'),
            'estimate-notes' => get_value(node, 'estimate-notes'),
            'description' => get_value(node, 'description'),
            'status' => get_value(node, 'status'),
            'invoice-status' => get_value(node, 'invoice-status'),
            'invoice-date' => get_value(node, 'invoice-date'),
            'invoice-paid-on' => get_value(node, 'invoice-paid-on'),
            'notification-sent' => get_value(node, 'notification-sent'),
            'total-expenses' => get_value(node, 'total-expenses')
        }
      end
    end
  end
end

