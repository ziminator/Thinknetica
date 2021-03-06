require_relative 'instance_counter.rb' #модуль
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :first, :last

  def initialize(first, last)
    @stations = [first, last]
    validate!
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

  protected
  def validate!
    raise "Первая и последняя станции не могут быть одинаковыми!" if first_station == last_station
    raise "Одна или обе станции не являются объектами класса Station!" if first_station.class != Station || last_station.class != Station
  end
end
