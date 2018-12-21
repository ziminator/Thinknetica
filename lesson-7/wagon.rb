class Wagon
  include Company
  attr_reader :type, :total, :free

  def initialize(type, qtty)
    @type = type
    @free = @total = qtty
  end

  def fill(amount)
    raise "В вагоне нет места! Повторите ввод:" if @free < amount
    @free -= amount
  end

  def busy
    @total - @free
  end
end
