class Wagon
  include Company
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def take_seats_volume(amount)    #Занять место/объём
    @seats_volume[:free] -= amount
    @seats_volume[:busy] += amount
  end

  def busy   #Вернуть кол-во занятых мест
    @seats_volume[:busy]
  end

  def free    #Вернуть количество свободных мест
    @seats_volume[:free]
  end

  def total
    @total
  end
end
