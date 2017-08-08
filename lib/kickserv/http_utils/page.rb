module Kickserv
  module HttpUtils
    module Page
      START_INDEX = 1
      END_INDEX = 50000

      def calculate_page_count(entity_type, params, start_index = START_INDEX, end_index=END_INDEX)
        index = start_index + ((end_index - start_index) / 2)
        result_at_index = call_api(entity_type, update_params(params, index))
          if result_at_index.empty?
          calculate_page_count(entity_type, params, start_index, index)
        else
          # special handling for greater than END_INDEX
          if (index + 1) > END_INDEX
            result_at_start = []
          else
            result_at_start = call_api(entity_type, update_params(params, index + 1))
          end

          # special handling for less than START_INDEX
          if (index - 1) < START_INDEX
            result_at_end = [1]
          else
            result_at_end = call_api(entity_type, update_params(params, index - 1))
          end
          if result_at_start.empty? && result_at_end.size > 0
            # end page found
            return index
          else
            # look for index which is not empty to
            calculate_page_count(entity_type, params, index, index + (index / 2) + 1)
          end
        end
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