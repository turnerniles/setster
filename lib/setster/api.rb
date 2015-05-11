module Setster
  class API

    URL = 'http://www.setster.com/api/v2'

    attr_reader :session_token

    # Create a new Setster session.
    # @param email [String]
    # @param api_key [String]
    # @return [Setster]
    def initialize(email, api_key)
      data = post("#{URL}/account/authenticate", email: email, token: api_key)
      @session_token = data['session_token']
    end

    # Retrieve the location list.
    #
    # @return [Array(Hash)]
    def location_list
      location_url = "#{URL}/location"
      get(location_url)
    end

    # Retrieve a list of service options.
    #
    # @return [Array(Hash)]
    def service_options
      service_url = "#{URL}/service"
      get(service_url)
    end

    private

    def get(url, query = {})
      query = { session_token: session_token }.merge(query) if session_token
      response = HTTParty.get(url, query: query, format: :json)

      if response.success?
        return response['data']
      else
        raise response.response
      end
    end

    def post(url, query = {})
      query = { session_token: session_token }.merge(query) if session_token
      response = HTTParty.post(url, query: query, format: :json)

      if response.success?
        return response.parsed_response['data']
      else
        raise response.response
      end
    end

  end
end