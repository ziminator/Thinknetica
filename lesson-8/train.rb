require_relative 'company.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'

# Class Train
class Train
  include Company
  include InstanceCounter
  include Validation
  NUMBER_TRAIN = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i.freeze
  attr_reader :number, :wagons, :speed, :type, :route, :index

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @wagons = []
    @speed = 0
    @index = 0
    @@trains[number] = self
    register_instance
  end

  def each_wagon
    return unless block_given?

    @wagons.each.with_index(1) { |wagon, index| yield(wagon, index) }
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

  def add_wagon(wagon)
    @wagons << wagon
  end

  def delete_wagon(wagon_id)
    @wagons.delete(wagon_id)
  end

  def go_forward
    if next_station
      current_station.left_train(self)
      @index += 1
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

  protected

  def validate!
    raise 'Введен некорректный номер поезда!' if @number !~ NUMBER_TRAIN
    raise 'Номер поезда не может быть пустым!' \
    if @number.nil? || @number.empty?
    raise 'Такой номер поезда уже есть!' if @@trains.include? @number
  end
end
