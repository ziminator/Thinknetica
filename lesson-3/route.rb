class Route
  attr_accessor :railway_station

  def initialize(first, last)
    @railway_stations = [first, last]
  end

  def add_station(r_station)
    railway_stations.insert(-2, r_station)
  end

  def remove_station(r_station)
    railway_stations.delete(r_station)
  end

  def route_show
    railway_stations.each { |station| puts station.name }
  end
end
