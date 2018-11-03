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
  attr_reader :number, :wagons, :speed, :type, :route, :index

  def initialize(number, type)
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

  def add_wagon   #Прицепить вагон к поезду
    if $choice_type == "Passenger"
      $train.wagons << PassengerWagon.new($train)
      puts "К поезду № - #{$train.number} добавлен пассажирский вагон, всего вагонов #{$train.wagons.count}"
    else
      $train.wagons << CargoWagon.new($train)
      puts "К поезду № - #{$train.number} добавлен товарный вагон, всего вагонов #{$train.wagons.count}"
    end
  end

  def delete_wagon   #Отцепить вагон от поезда
    if $train.wagons.count > 0
      $train.wagons.delete_at(-1)
      puts "От поезда № - #{$train.number} отцепили вагон, осталось вагонов #{$train.wagons.count}"
    else
      puts "У поезда № - #{$train.number} пока нет ни одного вагона!"
    end
  end

  def go_forward   #Переместить поезд на станцию вперёд
    max = $train.route.stations.size - 1
    @index = $train.index
    if @index == max
      puts "Поезд #{$train.number} находится на конечной станции #{$train.route.stations[@index].name}!"
    else
      puts "Поезд #{$train.number} отправляется со станции #{$train.route.stations[@index].name} на станцию #{$train.route.stations[@index + 1].name}."
      @index += 1
    end
  end

  def go_backward   #Переместить поезд на станцию назад
    index = $train.index
    if @index !=0
      puts "Поезд #{$train.number} отправляется со станции #{$train.route.stations[@index].name} на станцию #{$train.route.stations[@index - 1].name}."
      @index -= 1
    else
      puts "Поезд #{$train.number} находится на конечной станции #{$train.route.stations[@index].name}!"
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
