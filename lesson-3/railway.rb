def RomashkovoStation
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrived(train)
    trains << train
  end

  def train_left(train)
    trains.delete(train)
  end

  def trains_list
    trains.each { |train| puts train.number }
  end

  def trains_list_type(type)
    trains.each { |train| puts train if train.type == type }
  end
end
