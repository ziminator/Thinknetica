=begin

Класс Station (Станция):
-Имеет название, которое указывается при ее создании
-Может принимать поезда (по одному за раз)
-Может возвращать список всех поездов на станции, находящиеся в текущий момент
-Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
-Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

=end

class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def count_train(type)
    @trains.count { |train| train.type == type }
  end

  def left_train(train)
    @trains.delete(train)
  end
end
