module Kickserv
  class Client
    module Jobs
      def jobs(params={})
        XmlReader.new(get('jobs.xml', params)).jobs
      end
    end
  end
end
