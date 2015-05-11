module Setster
  class API

    URL = 'http://www.setster.com/api/v2/'

    attr_reader :session_token

    # Create a new Setster session.
    # @param email [String]
    # @param api_key [String]
    # @return [Setster]
    def initialize(email, api_key)
      data = post('/account/authenticate', email: email, token: api_key)
      @session_token = data['session_token']
    end

    # Retrieve the location list.
    #
    # @return [Array(Hash)]
    def location_list
      get('/location', location_url)
    end

    # Retrieve a list of service options.
    #
    # @return [Array(Hash)]
    def service_options
      get('/service', service_url)
    end

    private

    def get(path, query = {})
      query = { session_token: session_token }.merge(query) if session_token
      response = HTTParty.get("#{URL}#{path}", query: query, format: :json)

      if response.success?
        return response['data']
      else
        raise response.response
      end
    end

    def post(path, query = {})
      query = { session_token: session_token }.merge(query) if session_token
      response = HTTParty.post("#{URL}#{path}", query: query, format: :json)

      if response.success?
        return response.parsed_response['data']
      else
        raise response.response
      end
    end

  end
end