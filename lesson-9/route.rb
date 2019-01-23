require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'station.rb'

# Class route
class Route
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :stations, :first, :last

  validate :first, :presence
  validate :last, :presence
  validate :first, :type, class: Station
  validate :last, :type, class: Station

  def initialize(first, last)
    @stations = [first, last]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station) \
    if station != first_station && station != last_station
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
