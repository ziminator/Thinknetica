class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = "Passenger"
  end
end
