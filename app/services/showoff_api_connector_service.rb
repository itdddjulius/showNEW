#This class will connect the showoff API by Net::HTTP and RestClient. 
module ShowoffApiConnectorService
    require "uri"
    require "net/http"

    private

    #Function to call the Showoff Api's
    def showoff_api_call(api_link, api_type, authorization = nil, body = nil)
      url = URI(api_link)
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      
      #Using Net::HTTP and RestClient both to show their functionality and usability
      if api_type == "post"
        request = Net::HTTP::Post.new(url)
      elsif api_type == "put"
        request = Net::HTTP::Put.new(url)
      elsif api_type == "get"
        return JSON.parse(RestClient.get(api_link, authorization))
      elsif api_type == "delete"
        return JSON.parse(RestClient.delete(api_link, authorization))      
      end
  
      #Used for Net::Http
      request["Authorization"] = authorization if authorization.present?
      request["Content-Type"] = "application/json"
      request.body = body.to_json #converting the data into json format
      response = JSON.parse(https.request(request).read_body) #API called
      if response["message"] == "Your session has expired. Please login again to continue."
        refresh_token #to refresh token if it get expired
      else
        return response
      end
    end
  
    def refresh_token
      api_link = URI("https://showoff-rails-react-production.herokuapp.com/oauth/token")
  
      authorization = "Bearer " + current_user.showoff_access_token
      body = {
                "grant_type": "refresh_token",
                "refresh_token": current_user.showoff_refresh_token,
                "client_id": client_id,
                "client_secret": client_secret
              }.to_json
  
      response = showoff_api_call(api_link,"post", authorization, body)
      current_user.update_attributes(showoff_access_token: response["data"]["token"]["access_token"]) #updating token details in user table
      return response
    end
end