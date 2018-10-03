=begin

Класс Station (Станция):
-Имеет название, которое указывается при ее создании
-Может принимать поезда (по одному за раз)
-Может возвращать список всех поездов на станции, находящиеся в текущий момент
-Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
-Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

=end

class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def train_arrived(train)
    @trains << train
  end

  def trains_list
    trains.each { |train| train.number }
  end

  def trains_list_type(type)
    counter = 0
    trains.each { |train| counter += 1 if train.type.eql?(type) }
  end

  def train_left(train)
    trains.delete(train)
  end
end
