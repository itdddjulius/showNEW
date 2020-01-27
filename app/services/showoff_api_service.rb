#This class will consume showoff API calls by using ShowoffApiConnectorService class.
module ShowoffApiService
    include ShowoffApiConnectorService
    
    private

    #This method will list current user all widgets and other user visible widgets only. 
    def visible_widegts(user_id, user_info)
        begin
            if user_info.eql?("true") 
                my_widgets_url = MY_USER_WIDGETS + "client_id=#{client_id}&client_secret=#{client_secret}" 
                response = showoff_api_call(my_widgets_url, "get", authorization_bearer(current_user.showoff_access_token))
            else
                user_widgets_url = USER_WIDGETS + "#{user_id}/widgets/?client_id=#{client_id}&client_secret=#{client_secret}"
                response = showoff_api_call(user_widgets_url, "get", {})
            end    
            @user = response["data"]["widgets"].first["user"]
            @widgets = response["data"]["widgets"]
            response = 200
        rescue => exception
            flash[:error] = "Something went wrong in user show! #{exception}"
        end
    end

    private

    def client_id
        Rails.application.credentials.config[:client_id].to_s
    end

    def client_secret
        Rails.application.credentials.config[:client_secret].to_s
    end
    
    def authorization_bearer(token)
        {:Authorization => 'Bearer ' + token }
    end
end