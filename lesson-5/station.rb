require_relative 'instance_counter.rb' #модуль

class Station
  include InstanceCounter
  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def add_train(train)      #Принимаем поезда
    @trains << train
  end

  def list_train            #Список поездов на станции
    @trains
  end

  def type_train(type)     #Список поездов по типу
    @trains.select { |train| train.type == type }
  end

  def left_train(train)
    @trains.delete(train)
  end
end
