module Setster
  class API

    attr_reader :session_token

    # Create a new Setster session.
    # @param email [String]
    # @param api_key [String]
    # @return [Setster]
    def initialize(email, api_key)
      data = post('http://www.setster.com/api/v2/account/authenticate', email: email, token: api_key)
      @session_token = data['session_token']
    end

    # Retrieve the location list.
    #
    # @return [Array(Hash)]
    def location_list
      location_url = "http://www.setster.com/api/v2/location?session_token=#{session_token}"
      get(location_url)
    end

    # Retrieve a list of service options.
    #
    # @return [Array(Hash)]
    def service_options
      service_url = "http://www.setster.com/api/v2/service?session_token=#{session_token}"
      get(service_url)
    end

    private

    def get(url)
      response = HTTParty.get(url, format: :json)

      if response.success?
        return response['data']
      else
        raise response.response
      end
    end

    def post(url, data = {})
      response = HTTParty.post(url, query: data)

      if response.success?
        return response.parsed_response['data']
      else
        raise response.response
      end
    end

  end
end