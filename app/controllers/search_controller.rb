class SearchController < ApplicationController
  def index
    # @stations = Station.find_by_zip(params[:zip])

    @_conn = Faraday.new("https://api.data.gov") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['NREL_key']
    end

  response = @_conn.get do |req|
    req.url '/nrel/alt-fuel-stations/v1'
    req.params["fuel_type"] = "ELEC, LPG"
    req.params["zipcode"] = params[:zipcode]
    req.params["limit"] = 10
    req.params["format"] = 'json'
  end
  @stations = JSON.parse(response.body, symbolize_names: true)
end


end