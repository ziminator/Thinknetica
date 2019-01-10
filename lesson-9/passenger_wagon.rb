# Passenger wagon child class
class PassengerWagon < Wagon
  def initialize(seats)
    super(:passenger, seats)
  end

  def fill
    super(1)
  end
end
