require 'rspec'

RSpec.describe Kickserv::HttpUtils::Page do
  # Test jobs with get the specified page from Kickserv data.
  # Test case record the http response in
  # get_jobs_with_page_algorithm.yml file for offline mode.
  # This test case call http api.
  # Validate fields present in response.
  it 'should test page algorithm' do
    VCR.use_cassette("get_jobs_with_page_algorithm") do
      params = Hash.new
      params[:page] = 20
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      page_no = client.calculate_page_count('jobs', params, start_index = 1, end_index = params[:page])
      expect(page_no).to eq(20)
    end
  end

  # Test jobs with filter as page from Kickserv data.
  # Test case record the http response in
  # get_jobs_with_page_number.yml file for offline mode.
  # This test case call http api.
  # Validate fields present in response.
  it 'should get valid job data from Kickserv API with filter page number' do
    VCR.use_cassette("get_jobs_with_page_number") do
      client =  Kickserv::Client.new(api_key: 'API_KEY', subdomain: 'daffyducts')
      expect {client.jobs(page: 3000) {raise}}.to raise_error('There are only 203 data pages.')
    end
  end
end