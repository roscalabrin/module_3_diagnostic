class NrelService

  def initialize
    @_conn = Faraday.new("https://api.data.gov") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['NREL_key']
    end
  end
  
  def search_by_zipcode(params)
    response = conn.get do |req|
      req.url '/nrel/alt-fuel-stations/v1'
      req.params["fuel_type"] = "ELEC, LPG"
      req.params["zipcode"] = params[:q]
      req.params["limit"] = 10
      req.params["format"] = 'json'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    @_conn
  end
end

