module Kickserv
  module HttpUtils
    module Page
      START_INDEX = 1
      END_INDEX = 50000
      def calculate_page_count(entity_type, params, start_index = START_INDEX, end_index=END_INDEX)
        # Variable to return total number of available pages.
        @page_available = 0
        while(end_index >= start_index)
          # Calculate the mid of pages.
          mid = ((start_index + end_index)/2).floor
          # Check mid is present api list.
          result_at_index = call_api(entity_type, update_params(params, mid))
          if result_at_index != nil and (result_at_index.size > 0)
            # Update start to search page on right side.
            @page_available =  mid
            start_index = mid + 1
          else
            # Update the end to search page on left side.
            end_index = mid - 1
          end
        end
        @page_available
      end

      # Update Kickserv API params with the page number
      def update_params(params, page_number)
        if params.has_key?(:page)
          params[:page] = page_number
        else
          params['page'] = page_number
        end
        params
      end

      def call_api(entity_type, params)
        case entity_type
          when 'customers'
            CustomerXmlReader.new(get(path: 'customers.xml', params: params)).customers
          when 'jobs'
            JobXmlReader.new(get(path: 'jobs.xml', params: params)).jobs
        end
      end
    end
  end
end