class PassengerWagon < Wagon
  attr_reader :type

  def initialize(number)
    super
    @type = type
  end
end
