# Module to fill test data
module FillData
  # create stations
  def data_create_stations
    @stations << Station.new('Moscow')
    @stations << Station.new('Tver')
    @stations << Station.new('Bologoe')
    @stations << Station.new('St.Peterburg')
  end

  # Create trains
  def data_create_trains
    @trains << PassengerTrain.new('123-45')
    @trains << PassengerTrain.new('124-55')
    @trains << CargoTrain.new('223-46')
    @trains << CargoTrain.new('224-46')
  end

  # Add wagons to trains
  def data_add_wagons
    @trains[0].add_wagon(PassengerWagon.new(35.to_i))
    @trains[1].add_wagon(PassengerWagon.new(32.to_i))
    @trains[2].add_wagon(CargoWagon.new(428.to_i))
  end

  # Create routes
  def data_add_routes
    @routes << Route.new(@stations[0], stations[3])
    @routes << Route.new(@stations[1], stations[3])
    @routes << Route.new(@stations[0], stations[2])
  end

  # Add stations to routes
  def data_add_stations
    @routes[0].stations.insert(-2, @stations[1])
    @routes[0].stations.insert(-2, @stations[2])
    @routes[2].stations.insert(-2, @stations[1])
  end

  # Dedicate routes to trains
  def data_set_routes
    @trains[0].set_route(routes[0])
    @trains[2].set_route(routes[2])
  end
end
