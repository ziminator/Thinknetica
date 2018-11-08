class PassengerWagon < Wagon

  def initialize
    super(:passenger)
  end

  def add_wagon(wagon)
    if wagon.type == wagon
      super(:passenger)
    end
  end
end
