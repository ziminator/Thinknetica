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
    @stations = []
    @trains = []
    @routes = []
  end

  public  #Публичный метод, вызывающий и обрабатывающий меню

  def run
    @interface = Interface.new
    loop do
      @interface.menu
      choice = @interface.user_input.to_i
      case choice
      when 0 then exit                         #выход
      when 1 then add_stations                 #Создать станцию
      when 2 then add_train                    #Создать поезд
      when 3 then add_route                    #Создать маршрут
      when 4 then add_station_to_route         #Добавить станцию к маршруту
      when 5 then delete_station_from_route    #Удалить станцию из маршрута
      when 6 then add_route_to_train           #Назначить маршрут поезду
      when 7 then add_wagon_to_train           #Прицепить вагоны к поезду
      when 8 then delete_wagon_from_train      #Отцепить выгоны от поезда
      when 9 then move_forward                 #Переместить поезд по маршруту вперёд
      when 10 then move_backward               #Переместить поезд по маршруту назад
      when 11 then show_stations               #Отображать список станций
      when 12 then show_train_on_station       #Отобразить список поездов на станции
      end
    end
  end

  private   #Далее приватные методы, вызываемые только в этом классе из пунктов меню

  def add_stations   #1 Создать станцию
    @interface.puts_text(:station)
    name = @interface.user_input
    if @stations.map(&:name).include? name
      @interface.puts_result_station(false, name) #Станция уже есть
    else
      station = Station.new(name)
      new_stations(station)
      @interface.puts_result_station(true, name)  #Станции нет, добавляем
    end
  end

  def add_train  #2. Создать поезд
    @interface.puts_text(:num_train)
    number = @interface.user_input.to_i
    if @trains.map(&:number).include? number
      @interface.puts_double_train(number)
    else
      @interface.puts_text(:choice_type)
      submenu = @interface.user_input.to_i
      case submenu
      when 1
        @train = PassengerTrain.new(number)
        new_trains(@train)
        @interface.puts_pass_train(number)
      when 2
        @train = CargoTrain.new(number)
        new_trains(@train)
        @interface.puts_cargo_train(number)
      end
    end
  end

  def add_route  #3. Создать маршрут
    if show_stations
      @interface.puts_text(:choice_stations)
      @interface.puts_text(:first)
      first = @interface.user_input.to_i
      @interface.puts_text(:last)
      last = @interface.user_input.to_i
      return @interface.puts_text(:first_last) if first == last
      first = @stations[first - 1]
      last = @stations[last - 1]
      unless first && last
        @interface.puts_text(:new_stations)
        return
      end
      @route = Route.new(first, last)
      new_routes(@route)
      @interface.puts_create_route(@route)
    end
  end

  def add_station_to_route   #4. Добавить станцию к маршруту
    choice_route
    choice_station
    new_station_to_route = @stations[@station_index]
    update_routes = @routes[@route_index]
    if update_routes.stations.map(&:name).include? new_station_to_route.name
      @interface.puts_station_to_route(false, new_station_to_route)
    else
      update_routes.stations.insert(-2, new_station_to_route)
      @interface.puts_station_to_route(true, new_station_to_route)
    end
  end

  def delete_station_from_route   #5. Удалить станцию из маршрута
    choice_route
    choice_station
    route_station = @stations[@station_index]
    update_routes = @routes[@route_index]
    if update_routes.stations.map(&:name).include? route_station.name
      index = update_routes.stations.map(&:name).index route_station.name
      update_routes.stations.delete_at(index)
      @interface.puts_delete_from_route(true, route_station)
    else
      @interface.puts_delete_from_route(false, route_station)
    end
  end

  def add_route_to_train   #6. Назначить маршрут поезду
    if @trains.empty?
      @interface.puts_text(:empty_train)
      return
    else
     choice_train
    end
    choice_route
    get_route = @routes[@route_index]
    @train.set_route(get_route)
    @interface.puts_route_to_train(@train, @route_index, get_route)
  end

  def add_wagon_to_train   #7. Прицепить вагон к поезду
    choice_train
    if @choice_type == :passenger
      @wagon = PassengerWagon.new
      adding_wagon
      @interface.puts_add_pass_wagon(@train)
    else
      @wagon = CargoWagon.new
      adding_wagon
      @interface.puts_add_cargo_wagon(@train)
    end
  end

  def adding_wagon
    @train = @choice_train
    @train.add_wagon(@wagon)
  end

  def delete_wagon_from_train   #8. Отцепить вагон от поезда
    choice_train
    @train = @choice_train
    if @train.wagons.count > 0
      wagon_id = @train.wagons[-1]
      @train.delete_wagon(wagon_id)
      @interface.puts_delete_wagon(true, @train)
    else
      @interface.puts_delete_wagon(false, @train)
    end
  end

  def move_forward   #Переместить поезд на станцию вперёд
    max = @train.route.stations.size - 1
    index = @train.index
    if index == max
      @interface.puts_end_station(@train, index)
    else
      @train.go_forward
      @interface.puts_move_forward_train(@train, index)
    end
  end

  def move_backward   #Переместить поезд на пердыдущую станцию
    index = @train.index
    if index != 0
      @train.go_backward
      @interface.puts_move_backward_train(@train, index)
    else
      @interface.puts_end_station(@train, index)
    end
  end

  def show_stations  #11 Показать список станций
    if @stations.empty?
      @interface.puts_text(:empty_stations)
      return false
    else
      @interface.puts_text(:list_stations)
      @interface.puts_list_stations(@stations)
      @interface.puts_text(:divide)
      return true
    end
  end

  def show_train_on_station  #12 Показать список поездов (на станции)
    show_stations
    index = @interface.user_input.to_i
    if @stations[index - 1].list_train.empty?
      @interface.puts_on_station(false, @stations, index)
    else
      @interface.puts_on_station(true, @stations, index)
      @stations[index - 1].list_train
    end
  end

  def choice_train  #Выбор поезда
    @interface.puts_text(:choice_train)
    show_trains
    index = @interface.user_input.to_i
    @choice_train = @trains[index - 1]
    @choice_type = @choice_train.type
  end

  def show_trains  #Показать список поездов
    @interface.puts_list_trains(@trains)
    @interface.puts_text(:divide)
  end

  def choice_route
    @interface.puts_text(:choice_route)
    show_routes
    @route_index = @interface.user_input.to_i - 1
  end

  def choice_station
    @interface.puts_text(:choice_station)
    show_stations
    @station_index = @interface.user_input.to_i - 1
  end

  def show_routes  #Показать списки маршрутов
    @interface.puts_list_routes(@routes)
    @interface.puts_text(:divide)
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
end

main = Main.new
main.run
