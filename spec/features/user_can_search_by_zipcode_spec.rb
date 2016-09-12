require 'rails_helper'

feature 'User can search by zip code' do
  scenario 'they see a list of stations' do
    VCR.use_cassette("search_by_zipcode") do
      visit root_path

      fill_in :q, with: "80202"
      click_button "Locate"

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(search_path)

      within('h1') do
        expect(page).to have_content('Search Results')
      end
      
      within('h2') do
        expect(page).to have_content('Total Stations: 10')
      end
  
      expect(page).to_not have_content("E85")
      within('.stations-list') do
        expect(page).to have_content('Sacramento County Public Garage')
      end
      
      # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
    end
  end
end