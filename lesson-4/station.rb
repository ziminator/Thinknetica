=begin
Класс Station (Станция):
-Имеет название, которое указывается при ее создании
-Может принимать поезда (по одному за раз)
-Может возвращать список всех поездов на станции, находящиеся в текущий момент
-Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
-Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
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
