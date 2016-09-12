require 'rails_helper'

feature 'User can search by zip code' do
  scenario 'they see a list of stations' do
    VCR.use_cassette("search_by_zipcode") do
      visit root_path

      # within('.form-group search-field') do
      fill_in :q, with: "80203"
      click_button "Locate"
    # end

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(search_path)
      
      # Then I should see a list of the 10 closest stations within 6 miles sorted by distance
      
      # Then I should be on page "/search" with parameters visible in the url

      within('h1') do
        expect(page).to have_content('Search Results')
      end
      
      # And the stations should be limited to Electric and Propane
      # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
      expect(page).to have_content('Total Stations: 10')
    end
  end
end