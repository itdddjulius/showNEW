require 'rails_helper'

context 'User can log in and log out' do
  before(:each) do
    @user = User.create!(first_name: Faker::Name.name, last_name: Faker::Name.name, email: Faker::Internet.email,
                         password: 'password', password_confirmation: 'password',
                         showoff_access_token: '853cdf1f318125438134afd641b22059a2fe4e5d231a10803cbb0d36241978cf',
                         showoff_refresh_token: '1b16d6f621ca00810eeccf518a39324bfd33a7bae74b7bae08a45d2682f732e4')
  end

  describe 'User provides complete and correct credentials' do
    it 'logs the user in' do
      visit '/'
      click_on 'Login'
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password
      click_button 'Log in'
      expect(page).to have_content('Logout')
    end
  end

  describe 'User provides incomplete credentials' do
    it 'does not log the user in and redirects the user to the sign in screen' do
      visit '/'
      click_on 'Login'
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: ''
      click_button 'Log in'
      expect(current_path).to eq('/users/sign_in')
      expect(page).to have_content('Invalid Email or password.')
    end
  end

  describe 'User provides incorrect credentials' do
    it 'does not log the user in and redirects the user to the sign in screen' do
      visit '/'
      click_on 'Login'

      fill_in :user_email, with: @user.email
      fill_in :user_password, with: 'unity is a best policy!'

      click_button 'Log in'

      expect(current_path).to eq('/users/sign_in')
      expect(page).to have_content('Invalid Email or password.')
    end
  end

  describe 'User clicks sign out' do
    it 'signs the user out and redirects the user to the home screen' do
      visit '/'
      click_on 'Login'
      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password
      click_button 'Log in'
      expect(page).to have_content('Logout')
      sign_out @user
      visit '/'
      sign_out @user
      expect(page).to have_content(' Login')
    end
  end
end
