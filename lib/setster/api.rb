module Setster
  class API

    URL = 'http://www.setster.com/api/v2/'

    attr_reader :session_token

    # Create a new Setster session.
    # @param email [String]
    # @param api_key [String]
    # @return [Setster]
    def initialize(email, api_key)
      url = "account/authenticate?email=#{email}&token=#{api_key}"
      data = post(url)

      @session_token = data['session_token']

    end

    # Retrieve the location list.
    #
    # @param query [Hash]
    # @return [Array(Hash)]
    def locations(query = {})
      get('location', query)
    end

    # Retrieve a list of service options.
    #
    # @param query [Hash]
    # @return [Array(Hash)]
    def services(query = {})
      get('service', query)
    end

    def employee(query = {})
      get('employee', query)
    end

    def getavailabilitytime(employee_id, query = {})
      get("employee/getavailabilitytime/#{employee_id}", query)
    end

    def create_appointment(params)
      post('appointment', data: params)
    end


    private

    def get(path, query = {})
      query = { session_token: session_token }.merge(query) if session_token
      query.stringify_keys!
      response = HTTParty.get("#{URL}#{path}", query: query, format: :json)

      if response.success?
        return response['data']
      else
        raise "Setster: #{response['statusDescription']}"
      end
    end

    def post(path, query = {})
      query = { session_token: session_token }.merge(query) if session_token
      query.stringify_keys!
      response = HTTParty.post("#{URL}#{path}", data: query, format: :json)

      if response.success?
        return response.parsed_response['data']
      else
        raise "Setster: #{response['statusDescription']}"
      end
    end

  end
end