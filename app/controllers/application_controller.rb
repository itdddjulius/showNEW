class ApplicationController < ActionController::Base
  # showoff API client ID
  def client_id
    Rails.application.credentials.config[:client_id].to_s
  end

  # showoff API client secret
  def client_secret
    Rails.application.credentials.config[:client_secret].to_s
  end
end
