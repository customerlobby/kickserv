require File.expand_path('../../xml_utils/job_xml_reader', __FILE__)
require File.expand_path('../../http_utils/request', __FILE__)

module Kickserv
  module Models
    # Kickserv Job Model specific implementation
    module Job
      # include module http_utils to call kickserv apis to fetch data
      include HttpUtils::Request

      def jobs(params={})
        # Get all the jobs from kicksserv APIs and return
        JobXmlReader.new(get('jobs.xml', params)).jobs
      end
    end
  end
end