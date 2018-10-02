class Trains
  attr_accessor :wagons_num, :type, :speed

  def initialize(wagons_num = 0, type)
    @wagons_num = wagons_num
    @type = type
    @speed = 0
    @route = []
  end

  def start
    @speed = 30
    puts "Скорость поезда: #{@speed} км/ч"
  end

  def stay
    @speed = 0
  end

  def stop
    @speed = 0
    puts "Скорость поезда: #{@speed} км/ч"
  end

  def speed
    puts @speed
  end

  def speed_increase
    @speed += 10
    puts "Скорость поезда: #{@speed} км/ч"
  end

  def speed_reduce
    if @speed == 0
      puts "Поезд уже стоит: #{@speed} км/ч"
    else
      @speed -+ 10
    end
  end

  def wagon_add
    if stay
      @wagons_num += 1
    else
      puts "Перед прицеплением вагона необходимо остановить поезд!"
    end
  end

  def wagon_remove
    if stay && wagons_num > 0
      @wagons_num -= 1
    else
      puts "Перед отцепкой вагона необходимо остановить поезд!"
    end
  end

  def get_route(route)
    @route = route
    @station = route.first
  end

  def move_to(station)
    if @route.include?(station)
      @station = station
      puts "Поезд перегнан на станцию #{@station}"
    else
      puts "Перегон невозможен!"
    end
  end

  def current_station
    puts "Поезд на станции #{@station}"
  end
end
