json.extract! user, :id, :first_name, :last_name, :password, :email, :image_url, :client_id, :client_sceret, :date_of_birth, :created_at, :updated_at
json.url user_url(user, format: :json)
