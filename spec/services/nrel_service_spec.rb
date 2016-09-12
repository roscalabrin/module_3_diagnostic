require 'rails_helper'

describe NrelService do
  context "#search_by_zipcode" do 
    it "filters on parameters" do
      VCR.use_cassette("nrel_service_search") do
        stations = NrelService.new.search_by_zipcode(zipcode: "80203")
        station = stations.first

        expect(stations.count).to eq(10)
        expect(station).to have_key(:name)
        expect(station[:name].class).to eq String
        #fuel Types
        #Distance
        #access times
      end
    end
  end
end

