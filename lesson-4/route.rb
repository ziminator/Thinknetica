=begin
Класс Route (Маршрут):
-Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
-Может добавлять промежуточную станцию в список
-Может удалять промежуточную станцию из списка
-Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :stations, :first, :last

  def initialize(first, last)
    @first = first
    @last = last
    @stations = [first, last]
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
