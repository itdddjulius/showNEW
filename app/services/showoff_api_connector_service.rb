# This class will connect the showoff API by Net::HTTP and RestClient post put get and delete calls.
module ShowoffApiConnectorService
  require 'uri'
  require 'net/http'

  private

  # Function to call the Showoff Api's
  def showoff_api_call(api_link, api_type, authorization = nil, body = nil)
    response = send_request(api_link, api_type, authorization, body)
    if response['message'] == 'Your session has expired. Please login again to continue.'
      refresh_token # to refresh token if it get expired
      response = send_request(api_link, api_type, authorization, body) # API called again to treat the failed API call due to session expired.
    end
    response
  end

  def send_request(api_link, api_type, authorization = nil, body = nil)
    url = URI(api_link)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    # Using Net::HTTP and RestClient both to show their functionality and usability
    if api_type == 'post'
      request = Net::HTTP::Post.new(url)
    elsif api_type == 'put'
      request = Net::HTTP::Put.new(url)
    elsif api_type == 'get'
      return JSON.parse(RestClient.get(api_link, authorization))
    elsif api_type == 'delete'
      return JSON.parse(RestClient.delete(api_link, authorization))
    end

    # Used for Net::Http
    if authorization.present?
      request['Authorization'] = "Bearer #{current_user.reload.showoff_access_token}"
      end
    request['Content-Type'] = 'application/json'
    request.body = body.to_json # converting the data into json format
    JSON.parse(https.request(request).read_body) # API called
  end

  def refresh_token
    url = URI('https://showoff-rails-react-production.herokuapp.com/oauth/token')

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{current_user.showoff_access_token}"
    request.body = "{\n    \"grant_type\": \"refresh_token\",\n    \"refresh_token\": \"#{current_user.showoff_refresh_token}\",\n    \"client_id\": \"277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe\",\n    \"client_secret\": \"d6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352\"\n}"

    response = https.request(request)
    response = JSON.parse response.body
    current_user.update_attributes(showoff_access_token: response['data']['token']['access_token'], showoff_refresh_token: response['data']['token']['refresh_token']) # updating token details in user table
  end

  def authorization_bearer(token)
    { Authorization: 'Bearer ' + token }
  end
end
