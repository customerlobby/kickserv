# frozen_string_literal: true

require File.expand_path('../xml_utils/job_xml_reader', __dir__)
require File.expand_path('../http_utils/request', __dir__)

module Kickserv
  module Models
    # Kickserv Job Model specific implementation
    module Job
      # include module http_utils to call kickserv apis to fetch data
      include HttpUtils::Request

      # Added method to get jobs data with different filters.
      def jobs(params = {})
        # Get all the jobs from Kickserv APIs and return
        JobXmlReader.new(get(path: 'jobs.xml', params: params)).jobs
      end

      # Added method to filter job based on job-number.
      def job(job_number)
        JobXmlReader.new(get(url: get_url + 'jobs/',
                             path: "#{job_number}.xml")).job
      end
    end
  end
end
