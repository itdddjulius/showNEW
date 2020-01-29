require 'rails_helper'

context 'Guest Registration' do
  describe 'Guest provides all required information' do
    it 'registers the guest' do
      visit '/'
      click_on 'Sign Up'

      expect(current_path).to eq(new_user_registration_path)
      first_name = Faker::Name.name
      last_name = Faker::Name.name
      email = Faker::Internet.email
      fill_in :user_first_name, with: first_name
      fill_in :user_last_name, with: last_name
      fill_in :user_email, with: email
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      click_on 'Sign up'

      expect(current_path).to eq('/my_widgets')

      user = User.first

      expect(user.id).to eq(1)
      expect(user.first_name).to eq(first_name)
      expect(user.last_name).to eq(last_name)
      expect(user.email).to eq(email)
    end
  end

  describe 'Guest provides incomplete information' do
    it 'displays an error message and does not register the guest' do
      visit '/'
      click_on 'Sign Up'

      expect(current_path).to eq(new_user_registration_path)

      first_name = Faker::Name.name
      email = Faker::Internet.email
      fill_in :user_first_name, with: first_name
      fill_in :user_last_name, with: ''
      fill_in :user_email, with: email
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      click_on 'Sign up'

      expect(current_path).to eq('/users/sign_up')
      expect(page).to have_content("Last name can't be blank")
    end
  end
end
