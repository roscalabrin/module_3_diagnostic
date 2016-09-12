class NrelService

  def initialize
    @_conn = Faraday.new("https://api.data.gov") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['api_key'] = ENV['NREL_key']
    end
  end

  private

  def conn
    @_conn
  end
end

