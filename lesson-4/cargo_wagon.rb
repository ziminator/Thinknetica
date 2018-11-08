class CargoWagon < Wagon

  def initialize
    super(:cargo)
  end

  def add_wagon(wagon)
    if wagon.type == wagon
      super(:cargo)
    end
  end
end
