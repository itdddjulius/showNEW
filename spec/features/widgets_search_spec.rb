require 'rails_helper'

describe 'Widget Search' do
  context 'A guest enters keyword in the search box and' do
    it 'displays visible widgets matching the keyword' do
      VCR.use_cassette('Widgets Search Page') do
        visit '/widgets'

        fill_in :search, with: :ajax
        click_on 'Search'

        expect(current_path).to eq('/search')

        expect(page).to have_css('.widgets_list')
      end
    end
  end
end
