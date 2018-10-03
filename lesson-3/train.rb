=begin

Класс Train (Поезд):
-Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
-Может набирать скорость
-Может возвращать текущую скорость
-Может тормозить (сбрасывать скорость до нуля)
-Может возвращать количество вагонов
-Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
-Может принимать маршрут следования (объект класса Route).
-При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
-Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
-Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

=end

class Train
  attr_reader :number, :type, :wagons, :speed :current_station :current_station_id

  def initialize(number, type, wagons = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @current_station_id = 0
  end

  def speed_increase(value)
    @speed += value
  end

  def speed
    @speed
  end

  def speed_reduce(value)
    if @speed == 0
      @speed
    else
      @speed -= value
    end
  end

  def wagons
    @wagons = wagons
  end

  def add_wagons
    @wagons += 1 if @speed == 0
  end

  def remove_wagons
    @wagons -=1 if @speed == 0 && @wagons > 0
  end

  def get_route
    @current_station = route.stations
  end

  def start_route
    @current_station = route.stations[0]
  end

  def route_go_forward
    @current_station_id = route.stations
    if @current_station_id != route.stations[-1]
      @current_station_id += 1
      @current_station = route.stations[current_station_id]
    end

  def route_go_backward
    @current_station_id = route.stations
    if @current_station_id != route.stations[0]
    @current_station_id -= 1
    @current_station = route.stations[current_station_id]
  end

  def previous_station(station)
    @current_station_id = route.stations
    if @current_station_id != route.stations[0]
      @current_station_id -= 1
      @station = route.stations[current_station_id]
    else
      @station = route.stations
    end
  end

  def curr_station(station)
    @station = route.station
  end

  def next_station(station)
    @current_station_id = route.stations
    if @current_station_id != route.stations[-1]
      @current_station_id += 1
      @station = route.stations[current_station_id]
    else
      @station = route_station
    end
  end
end
