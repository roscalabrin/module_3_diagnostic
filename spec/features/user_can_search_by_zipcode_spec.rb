require 'rails_helper'

feature 'User can search by zip code' do
  scenario 'they see a list of stations' do
    VCR.use_cassette("search_by_zipcode") do
      visit root_path

      fill_in :q, with: "80203"
      click_button "Locate"

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(search_path)

      within('h1') do
        expect(page).to have_content('Search Results')
      end
      
      within('h2') do
        expect(page).to have_content('Total Stations: 10')
      end
      
      within('.stations-list:nth-child(1)') do
      expect(page).to have_content('Sacramento County Public Garage')
    end
      # And the stations should be limited to Electric and Propane
      # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
    end
  end
end