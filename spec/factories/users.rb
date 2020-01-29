FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'User' }
    password { 'password' }
    password_confirmation { 'password' }
    email { 'test191@showoff.ie' }
    image_url { 'https://static.thenounproject.com/png/961-200.png' }
  end
end
