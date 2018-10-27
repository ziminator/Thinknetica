=begin
Разбить программу на отдельные классы (каждый класс в отдельном файле)
Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. В комментарии к методу обосновать, почему он был вынесен в private/protected
Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
При добавлении вагона к поезду, объект вагона должен передаваться как аругмент метода и сохраняться во внутреннем массиве поезда, в отличие от предыдущего задания,
где мы считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.

Добавить текстовый интерфейс:

Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     - Создавать станции
     - Создавать поезда
     - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
     - Назначать маршрут поезду
     - Добавлять вагоны к поезду
     - Отцеплять вагоны от поезда
     - Перемещать поезд по маршруту вперед и назад
     - Просматривать список станций и список поездов на станции

В качестве ответа приложить ссылку на репозиторий с решением
=end

require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

@stations = []
@trains = []
@routes = []

def main_add_stations   #1 Создать станцию
  name_station = user_input("Введите название станции:")
  unless @stations.map { |station| station.name }.include? name_station
    station = Station.new(name_station)
    new_stations(station)
    puts "Станция #{station.name} создана!"
  else
    puts "Станция #{name_station} уже есть, введите другое название станции!"
  end
end

def main_add_train  #2. Создать поезд
  number_train = user_input("Введите номер поезда:").to_i
  submenu = user_input("Выберите тип поезда: 1 - Пассажирский; 2 - Товарный").to_i
  unless @trains.map { |train| train_number }.include? number_train
    loop do
      case submenu
      when 1
        train = PassengerTrain.new(number_train)
        new_trains(train)
        puts "Создан пассажирский поезд №#{number_train}"
        break
      when 2
        train = CargoTrain.new(number_train)
        new_trains(train)
        puts "Создан товарный поезд №#{number_train}"
        break
      end
    else
      puts "Выбран неверный тип поезда, повторите выбор ещё раз:"
    end
  else
    puts "Поезд с номером #{number_train} уже есть, введите другой номер поезда!"
  end
end

def main_add_route  #3. Создать маршрут
  if main_show_stations
    puts "Выберите из списка станции,"
    first = user_input("Начальную:").to_i
    last = user_input("Конечную:").to_i
    return puts "Первая и последняя станция не могут быть одинаковыми!" if first == last
    first = @stations[first - 1]
    last = @stations[last - 1]
    unless first && last
      puts "Выбраны несуществующие станции!"
      return
    end
    route = Route.new(first, last)
    new_routes(route)
    puts "Создан маршрут #{route.first.name}, #{route.last.name}"
  end
end

def main_add_station_to_route   #4. Добавить станцию к маршруту
  add_delete_station_intro
  new_station_to_route = @stations[@choice_station]
  update_routes = @routes[@choice_route]
  unless update_routes.stations.map { |station| station.name }.include? new_station_to_route.name
    update_routes.stations.insert(-2, new_station_to_route)
    puts "Станция #{new_station_to_route.name} добавлна в маршрут."
  else
    puts "Станция #{new_station_to_route.name} уже есть в маршруте, выберите другую станцию!"
  end
end

def main_delete_station_from_route   #5. Удалить станцию из маршрута
  add_delete_station_intro
  route_station = @stations[@choice_station]
  update_routes = @routes[@choice_route]
  if update_routes.stations.map { |station| station.name }.include? route_station.name
    index = update_routes.stations.map { |station| station.name }.index route_station.name
    update_routes.stations.delete_at(index)
    puts "Станция #{route_station.name} удалена из маршрута."
  else
    puts "Станции #{route_station.name} нет в маршруте, выберите другую станцию!"
  end
end

def main_add_route_to_train   #6. Назначить маршрут поезду
  choice_train
  puts "Выберите маршрут:"
  main_show_routes
  route_index = gets.to_i - 1
  choice_route = @routes[route_index]
  @train.set_route(choice_route)
  puts "Поезду с № - #{@train.number} назначен маршрут #{route_index + 1}. #{choice_route.first.name} - #{choice_route.last.name}"
  #puts choice_train.stations.name
end

def main_add_wagon_to_train   #7. Прицепить вагон к поезду
  choice_train
  if @choice_type == "Passenger"
    @train.wagons << PassengerWagon.new(@train)
    puts "К поезду № - #{@train.number} добавлен пассажирский вагон, всего вагонов #{@train.wagons.count}"
  else
    @train.wagons << CargoWagon.new(@train)
    puts "К поезду № - #{@train.number} добавлен товарный вагон, всего вагонов #{@train.wagons.count}"
  end
end

def main_delete_wagon_from_train   #8. Отцепить вагон от поезда
  choice_train
  if @train.wagons.count > 0
    @train.wagons.delete_at(-1)
    puts "От поезда № - #{@train.number} отцепили вагон, осталось вагонов #{@train.wagons.count}"
  else
    puts "У поезда № - #{@train.number} пока нет ни одного вагона!"
  end
end

def main_train_move_forvard   #9. Переместить поезд на станцию вперёд
  choice_train
  max = @train.route.stations.size - 1
  index = @train.moving_index
  if index == max
    puts "Поезд #{@train.number} находится на конечной станции #{@train.route.stations[index].name}!"
  else
    puts "Поезд #{@train.number} отправляется со станции #{@train.route.stations[index].name} на станцию #{@train.route.stations[index + 1].name}."
    @train.moving_index += 1
  end
end

def main_train_move_backward   #9. Переместить поезд на станцию назад
  choice_train
  index = @train.moving_index
  if index !=0
    puts "Поезд #{@train.number} отправляется со станции #{@train.route.stations[index].name} на станцию #{@train.route.stations[index - 1].name}."
    @train.moving_index -= 1
  else
    puts "Поезд #{@train.number} находится на конечной станции #{@train.route.stations[index].name}!"
  end
end

def main_show_stations  #11 Показать список станций
  unless @stations.empty?
    puts "Список станций:"
    @stations.each.with_index(1) { |station, index| puts "#{index} - #{station.name} "}
    puts "---------------"
    return true
  else
    puts "Станций пока нет, сначала добавьте станции!"
    return false
  end
end

def main_show_train_on_station  #12 Показать список поездов (на станции)
  main_show_stations
  index = gets.to_i
  puts "На станции #{@stations[index - 1].name} находится:"
  @stations[index - 1].list_train
end

def main_show_trains  #Показать список поездов
  @trains.each.with_index(1) { |train, index| puts "#{index}: #{train.number} #{train.type}" }
  puts "---------------"
end

def main_show_routes  #Показать списки маршрутов
  @routes.each.with_index(1) { |route, index| puts "#{index}: #{print_routes route}" }
  puts "---------------"
end

def print_routes(route)
  stations_names = []
  stations_names = route.stations.map { |station| station.name }
  return stations_names
end

def add_delete_station_intro
  puts "Выберите маршрут:"
  main_show_routes
  @choice_route = gets.to_i - 1
  puts "Выберите станцию:"
  main_show_stations
  @choice_station = gets.to_i - 1
end

def choice_train
  puts "Выберите поезд:"
  main_show_trains
  index = gets.to_i
  @train = @trains[index - 1]
  @choice_type = @train.type
end

def new_stations(station)
  @stations << station
end

def new_routes(route)
  @routes << route
end

def new_trains(train)
  @trains <<  train
end

def user_input(text)
  puts text
  gets.chomp
end

loop do
  puts "Выберите пункт меню:
  =======================================
  1   - Создать станцию
  2   - Создать поезд
  3   - Создать маршрут
  4   - Добавить станцию к маршруту
  5   - Удалить станцию из маршрута
  6   - Назначить маршрут поезду
  7   - Прицепить вагон к поезду
  8   - Отцепить вагон от поезда
  9   - Переместить поезд на станцию вперёд
  10  - Переместить поезд на станцию назад
  11  - Просмотреть список станций
  12  - Просмостреть список поездов на станции
  _______________________________________
  0   - ВЫХОД
  ======================================="
  menu = gets.to_i
  case menu
  when 0  #выход
    exit
  when 1  #Создать станцию
    main_add_stations
  when 2  #Создать поезд
    main_add_train
  when 3  #Создать маршрут
    main_add_route
  when 4  #Добавить станцию к маршруту
    main_add_station_to_route
  when 5  #Удалить станцию из маршрута
    main_delete_station_from_route
  when 6  #Назначить маршрут поезду
    main_add_route_to_train
  when 7  #Прицепить вагоны к поезду
    main_add_wagon_to_train
  when 8  #Отцепить выгоны от поезда
    main_delete_wagon_from_train
  when 9  #Переместить поезд по маршруту вперёд
    main_train_move_forvard
  when 10 #Переместить поезд по маршруту назад
    main_train_move_backward
  when 11 #Отображать список станций
    main_show_stations
  when 12 #Отобразить список поездов на станции
    main_show_train_on_station
  end
end
