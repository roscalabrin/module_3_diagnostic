class Station < OpenStruct
  
  def self.service
    @service = NrelService.new
  end
  
  def self.find_by_zipcode(zip)
    raw_response = service.find_by_zip(zip)

    stations = raw_response[:fuel_stations].map do |station|
      Station.new(station)
    end
  end
  
end