# Child class cargo wagon
class CargoWagon < Wagon
  def initialize(volume)
    super(:cargo, volume)
  end
end
