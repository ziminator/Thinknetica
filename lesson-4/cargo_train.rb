class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super(number, :cargo)
    @type = "Cargo"
  end
end
