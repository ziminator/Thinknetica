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
  attr_reader :speed, :wagons, :index, :index, :route, :current_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons.to_i
    @speed = 0
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

  def add_wagon
    @wagons += 1 if @speed == 0
  end

  def delete_wagon
    @wagons -=1 if @speed == 0 && @wagons > 0
  end

  def set_route(route)
    @route[@index].left_train(self) if current_station != nil
    @route = route.stations
    @current_station = @route[@index]
    @route[0].add_train(self)
  end

  def go_forward(route)
    if @index + 1 != @route.length
      @route[@index].left_train(self)
      @index += 1
      @current_station = @route[@index]
      @route[@index].add_train
    else
      @route[-1]
    end

  def go_backward(route)
    if @index != 0
      @route[@index].left_train(self)
      @index -= 1
      @current_station = @route[@index]
      @route[@index].add_train
    else
      @route[0]
    end
  end

  def current_station
    @current_station
  end

  def next_station
    if @index + 1 != @route.length
      @route[@index + 1]
    else
      @route[-1]
    end
  end

  def prev_station
    if @index != 0
      @route[@index - 1]
    else
      @route[0]
    end
  end
end
