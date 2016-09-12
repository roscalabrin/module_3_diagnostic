class NrelService
  
  def initialize
    @_conn = Faraday.new("https://api.data.gov") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['NREL_key']
    end
  
  def find_by_zipcode(zip)
    response = @_conn.get do |req|
      req.url '/nrel/alt-fuel-stations/v1'
      req.params["fuel_type"] = "ELEC, LPG"
      req.params["zip"] = params[:q]
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

