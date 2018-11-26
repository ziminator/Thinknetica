require_relative 'instance_counter.rb' #модуль

class Route
  include InstanceCounter

  attr_reader :stations, :first, :last

  def initialize(first, last)
    @first = first
    @last = last
    @stations = [first, last]
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) if station != first_station && station != last_station
  end

  def show_stations
    stations.each { |station| puts station }
  end

  def first_station
    @stations[0]
  end

  def last_station
    @stations[-1]
  end
end
