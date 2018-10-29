=begin
Класс Train (Поезд):
-Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
эти данные указываются при создании экземпляра класса
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
  attr_accessor :index
  attr_reader :number, :wagons, :speed, :type, :route

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @type = type
    @index = 0
  end

  def speed_increase(value)
    @speed += value
  end

  def speed_reduce(value)
    if @speed < value
      @speed = 0
    else
      @speed -= value
    end
  end

  def set_route(route)
    @route = route
    current_station.add_train(self)
  end

  def go_forward
    if next_station
      current_station.left_train(self)
      @index +=1
      current_station.add_train(self)
    end
  end

  def go_backward
    if prev_station
      current_station.left_train(self)
      @index -= 1
      current_station.add_train(self)
    end
  end

  def current_station
    @route.stations[@index]
  end

  def next_station
    @route.stations[@index + 1] if current_station != @route.last_station
  end

  def prev_station
    @route.stations[@index - 1] if current_station != @route.first_station
  end
end
