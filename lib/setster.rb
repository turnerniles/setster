require 'setster/version'
require 'httparty'


module Setster

  attr_reader :session_token

  # Create a new Setster session.
  # @param email [String]
  # @param api_key [String]
  # @return [Setster]
  def initialize(email, api_key)
    url = "http://www.setster.com/api/v2/account/authenticate?email=#{email}&token=#{api_key}"
    response = HTTParty.post(url)
    @session_token = response["data"]["session_token"]
  end

  # Retrieve the location list.
  def location_list
    location_url = "http://www.setster.com/api/v2/location?session_token=#{session_token}"
    HTTParty.get(location_url)
  end

  def service_options
    service_url = "http://www.setster.com/api/v2/service?session_token=#{session_token}"
    HTTParty.get(service_url)
  end
end
