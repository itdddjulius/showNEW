require 'rails_helper'
context 'Signed in user can' do
  describe 'see all of their own widgets' do
    it 'displays hidden and visible widgets created by the current user' do
      VCR.use_cassette('User Widgets Index Page') do
        user = User.create!(first_name: 'Me', last_name: 'Myself', email: 'me@me.com',
                            password: 'password', password_confirmation: 'password',
                            showoff_access_token: '853cdf1f318125438134afd641b22059a2fe4e5d231a10803cbb0d36241978cf',
                            showoff_refresh_token: '1b16d6f621ca00810eeccf518a39324bfd33a7bae74b7bae08a45d2682f732e4')
        sign_in user
        visit '/my_widgets'
        expect(page).to have_content('My Widgets')
      end
    end
  end

  describe 'Create a widget' do
    it 'displays the newly created in the user\'s list of widgets' do
      VCR.use_cassette('User Create Widget Page') do
        user = User.create!(first_name: 'Me', last_name: 'Myself', email: 'me@me.com',
                            password: 'password', password_confirmation: 'password',
                            showoff_access_token: '853cdf1f318125438134afd641b22059a2fe4e5d231a10803cbb0d36241978cf',
                            showoff_refresh_token: '1b16d6f621ca00810eeccf518a39324bfd33a7bae74b7bae08a45d2682f732e4')
        sign_in user
        visit '/my_widgets'

        click_on 'New Widget'

        expect(current_path).to eq(new_widget_path)

        fill_in 'widget_name', with: Faker::Name.name
        fill_in 'widget_description', with: Faker::Hipster.sentence
        find('#widget_kind').find(:xpath, 'option[2]').select_option

        click_on 'Create Widget'

        expect(current_path).to eq('/my_widgets')
      end
    end
  end

  describe 'Edit a widget' do
    it 'displays the edited in the user\'s list of widgets' do
      VCR.use_cassette('User Edit Widget Page') do
        user = User.create!(first_name: 'Me', last_name: 'Myself', email: 'me@me.com',
                            password: 'password', password_confirmation: 'password',
                            showoff_access_token: '853cdf1f318125438134afd641b22059a2fe4e5d231a10803cbb0d36241978cf',
                            showoff_refresh_token: '1b16d6f621ca00810eeccf518a39324bfd33a7bae74b7bae08a45d2682f732e4')
        sign_in user
        visit '/my_widgets'

        click_on 'New Widget'

        expect(current_path).to eq(new_widget_path)

        fill_in 'widget_name', with: Faker::Name.name
        fill_in 'widget_description', with: Faker::Hipster.sentence
        find('#widget_kind').find(:xpath, 'option[2]').select_option

        click_on 'Create Widget'

        expect(current_path).to eq('/my_widgets')

        visit '/my_widgets'

        visit "/widgets/#{Widget.last.showoff_widget_id}/edit/"

        # first(:link, 'Edit').click

        fill_in 'widget_description', with: Faker::Hipster.sentence

        click_on 'Update Widget'

        expect(current_path).to eq('/my_widgets')
      end
    end
  end

  describe 'Delete a widget' do
    it 'deleted widget is not displayed in the user\'s list of widgets' do
      VCR.use_cassette('User Delete Widget Page') do
        user = User.create!(first_name: 'Me', last_name: 'Myself', email: 'me@me.com',
                            password: 'password', password_confirmation: 'password',
                            showoff_access_token: '853cdf1f318125438134afd641b22059a2fe4e5d231a10803cbb0d36241978cf',
                            showoff_refresh_token: '1b16d6f621ca00810eeccf518a39324bfd33a7bae74b7bae08a45d2682f732e4')
        sign_in user
        visit '/my_widgets'

        click_on 'New Widget'

        expect(current_path).to eq(new_widget_path)

        fill_in 'widget_name', with: Faker::Name.name
        fill_in 'widget_description', with: Faker::Hipster.sentence
        find('#widget_kind').find(:xpath, 'option[2]').select_option

        click_on 'Create Widget'

        expect(current_path).to eq('/my_widgets')

        visit "/delete_widget/#{Widget.last.showoff_widget_id}"
        expect(current_path).to eq('/my_widgets')
      end
    end
  end
end
