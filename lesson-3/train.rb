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
  attr_accessor :speed
  attr_reader :index, :route, :type, :wagons

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons.to_i
    @speed = 0
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

  def add_wagon
    @wagons += 1 if @speed == 0
  end

  def delete_wagon
    @wagons -=1 if @speed == 0 && @wagons > 0
  end

  def set_route(route)
    @route = route
    @index = 0
    @route.stations[@index].add_train(self)
  end

  def go_forward
    if @index + 1 != @route.stations.length     #Не стал использовать unless.
      @route.stations[@index].left_train(self)  #По-моему, так короче.
      @index +=1
      @route.stations[@index].add_train(self)
    end
  end

  def go_backward
    if @index >= 1
      @route.stations[@index].left_train(self)
      @index -= 1
      @route.stations[@index].add_train(self)
    end
  end

  def current_station
    @route.stations[@index]
  end

  def next_station
    if @index + 1 != @route.stations.length
      @route.stations[@index + 1]
    end
  end

  def prev_station
    if @index >= 1
      @route.stations[@index - 1]
    end
  end
end
