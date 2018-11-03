class Interface

  def user_input(text)
    puts text
    gets.chomp
  end

  def choice_route
    puts "Выберите маршрут:"
    list_routes
    $route_index = gets.to_i - 1
    $choice_route = $routes[$route_index]
  end

  def choice_station
    puts "Выберите станцию:"
    list_stations
    $choice_station = gets.to_i - 1
  end

  def choice_train
    puts "Выберите поезд:"
    list_trains
    index = gets.to_i
    $choice_train = $trains[index - 1]
    $choice_type = $choice_train.type
  end

  def list_trains  #Показать список поездов
    $trains.each.with_index(1) { |train, index| puts "#{index}: #{train.number} #{train.type}" }
    puts "---------------"
  end

  def list_routes  #Показать списки маршрутов
    $routes.each.with_index(1) { |route, index| puts "#{index}: #{print_routes route}" }
    puts "---------------"
  end

  def print_routes(route)
    stations_names = []
    stations_names = route.stations.map { |station| station.name }
    return stations_names
  end

  def list_stations
    unless $stations.empty?
      puts "Список станций:"
      $stations.each.with_index(1) { |station, index| puts "#{index} - #{station.name} "}
      puts "---------------"
      return true
    else
      puts "Станций пока нет, сначала добавьте станции!"
      return false
    end
  end
end
