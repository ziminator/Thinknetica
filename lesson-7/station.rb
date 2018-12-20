require_relative 'instance_counter.rb' #модуль
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation
  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def each_train
   return unless block_given?
   @trains.each { |train| yield(train) }
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

  protected
  def validate!
    raise "Наименование станции не введено, повторите попытку!" if @name.empty?
    raise "Станция с таким нименованием уже есть, придумате другое название!" if @@stations.map(&:name).include? @name
  end
end
