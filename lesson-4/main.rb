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

require_relative 'menu.rb'
require_relative 'interface.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
    $stations = []
    $trains = []
    $routes = []
  end

  public  #Публичный метод, вызывающий и обрабатывающий меню

  def run
    menu = Menu.new
    @interface = Interface.new
    loop do
      menu.puts_menu
      choice = gets.to_i
      case choice
        when 0 then exit                                  #выход
        when 1 then add_stations               #Создать станцию
        when 2 then add_train                  #Создать поезд
        when 3 then add_route                   #Создать маршрут
        when 4 then add_station_to_route       #Добавить станцию к маршруту
        when 5 then delete_station_from_route  #Удалить станцию из маршрута
        when 6 then add_route_to_train         #Назначить маршрут поезду
        when 7 then add_wagon_to_train         #Прицепить вагоны к поезду
        when 8 then delete_wagon_from_train    #Отцепить выгоны от поезда
        when 9 then move_forward         #Переместить поезд по маршруту вперёд
        when 10 then move_backward       #Переместить поезд по маршруту назад
        when 11 then show_stations             #Отображать список станций
        when 12 then show_train_on_station     #Отобразить список поездов на станции
      end
    end
  end

  private   #Далее приватные методы, вызываемые только в этом классе из пунктов меню

  def add_stations   #1 Создать станцию
    name = @interface.user_input("Введите название станции:")
    unless $stations.map { |station| station.name }.include? name
      station = Station.new(name)
      new_stations(station)
      puts "Станция #{station.name} создана!"
    else
      puts "Станция #{name} уже есть, введите другое название станции!"
    end
  end

  def add_train  #2. Создать поезд
    number = @interface.user_input("Введите номер поезда:").to_i
    submenu = @interface.user_input("Выберите тип поезда: 1 - Пассажирский; 2 - Товарный").to_i
    unless $trains.map { |train| train }.include? number
      case submenu
      when 1
        $train = PassengerTrain.new(number)
        new_trains($train)
        puts "Создан пассажирский поезд №#{number}"
      when 2
        $train = CargoTrain.new(number)
        new_trains($train)
        puts "Создан товарный поезд №#{number}"
      end
    else
      puts "Поезд с номером #{number} уже есть, введите другой номер поезда!"
    end
  end

  def add_route  #3. Создать маршрут
    if show_stations
      puts "Выберите из списка станции,"
      first = @interface.user_input("Начальную:").to_i
      last = @interface.user_input("Конечную:").to_i
      return puts "Первая и последняя станция не могут быть одинаковыми!" if first == last
      first = $stations[first - 1]
      last = $stations[last - 1]
      unless first && last
        puts "Выбраны несуществующие станции!"
        return
      end
      $route = Route.new(first, last)
      new_routes($route)
      puts "Создан маршрут #{$route.first.name}, #{$route.last.name}"
    end
  end

  def add_station_to_route   #4. Добавить станцию к маршруту
    @interface.choice_route
    @interface.choice_station
    new_station_to_route = $stations[$choice_station]
    update_routes = $routes[$route_index]
    unless update_routes.stations.map { |station| station.name }.include? new_station_to_route.name
      update_routes.stations.insert(-2, new_station_to_route)
      puts "Станция #{new_station_to_route.name} добавлна в маршрут."
    else
      puts "Станция #{new_station_to_route.name} уже есть в маршруте, выберите другую станцию!"
    end
  end

  def delete_station_from_route   #5. Удалить станцию из маршрута
    @interface.choice_route
    @interface.choice_station
    route_station = $stations[$choice_station]
    update_routes = $routes[$route_index]
    if update_routes.stations.map { |station| station.name }.include? route_station.name
      index = update_routes.stations.map { |station| station.name }.index route_station.name
      update_routes.stations.delete_at(index)
      puts "Станция #{route_station.name} удалена из маршрута."
    else
      puts "Станции #{route_station.name} нет в маршруте, выберите другую станцию!"
    end
  end

  def add_route_to_train   #6. Назначить маршрут поезду
    @interface.choice_train
    @interface.choice_route
    $train.set_route($choice_route)
    puts "Поезду с № - #{$train.number} назначен маршрут #{$route_index + 1}. #{$choice_route.first.name} - #{$choice_route.last.name}"
  end

  def add_wagon_to_train   #7. Прицепить вагон к поезду
    @interface.choice_train
    $train.add_wagon
  end

  def delete_wagon_from_train   #7. Отцепить вагон от поезда
    @interface.choice_train
    $train.delete_wagon
  end

  def move_forward   #9. Переместить поезд на станцию вперёд
    @interface.choice_train
    $train.go_forward
  end

  def move_backward   #10. Переместить поезд на станцию назад
    @interface.choice_train
    $train.go_backward
  end

  def show_stations  #11 Показать список станций
    @interface.list_stations
  end

  def show_train_on_station  #12 Показать список поездов (на станции)
    show_stations
    index = gets.to_i
    unless $stations[index - 1].list_train.empty?
      puts "На станции #{$stations[index - 1].name} находятся:"
      $stations[index - 1].list_train
    else
      puts "На станции #{$stations[index - 1].name} нет поездов."
    end
  end

  def new_stations(station)
    $stations << station
  end

  def new_routes(route)
    $routes << route
  end

  def new_trains(train)
    $trains <<  train
  end
end

main = Main.new
main.run
