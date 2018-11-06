class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number, :passenger)
    @type = "Passenger"
  end
end
