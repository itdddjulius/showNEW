require 'rails_helper'

describe 'Widgets Page' do
  context 'A guest visits the widgets page and' do
    it 'displays all visible widgets and the name of the widget\'s creator' do
      VCR.use_cassette('Widgets Index Page') do
        visit '/widgets'

        expect(page).to have_content('Widgets')
        expect(page).to have_css('.search_button', count: 1)
      end
    end
  end

  context 'A guest clicks on the creator name and' do
    it 'displays all visible widgets created by a specific user' do
      VCR.use_cassette('Widgets by User Page') do
        visit '/widgets'

        within(first('.widgets_list')) do
          find_link('198').click
        end

        expect(current_path).to eq('/users/198')
        expect(page).to have_content('Ali')
      end
    end
  end
end
