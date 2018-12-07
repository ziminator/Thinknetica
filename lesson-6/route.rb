require_relative 'instance_counter.rb' #модуль
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :first, :last

  def initialize(first, last)
    @stations = [first, last]
    register_instance
    validate!(first, last)
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
  def validate!(first, last)
    raise "Первая и последняя станции не могут быть одинаковыми!" if first == last
    raise "Одна или обе станции не являются объектами класса Station!" if first.class != Station || last.class != Station
  end
end
