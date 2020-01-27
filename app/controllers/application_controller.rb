class ApplicationController < ActionController::Base

  def client_id
    Rails.application.credentials.config[:client_id].to_s
  end

  def client_secret
      Rails.application.credentials.config[:client_secret].to_s
  end


end
