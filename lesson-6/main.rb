require_relative 'interface.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'validation.rb'
require_relative 'instance_counter.rb'

class Main
  attr_reader :stations, :trains, :routes
  include InstanceCounter
  include Validation

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @number = nil
  end

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
      when 13 then test_station_objects        #Список объектов станций (тест)
      when 14 then test_find_objects           #Класс find (тест)
      end
    end
  end

  private   #Далее приватные методы, вызываемые только в этом классе из пунктов меню

  def test_station_objects
    @interface.puts_objects_stations
  end

  def test_find_objects
    Train.find(@number)
    @interface.puts_train_find(@number)
  end

  def add_stations   #1 Создать станцию
    @interface.puts_text(:station)
    @name = @interface.user_input.to_s
    return unless valid?(:station)
    station = Station.new(@name)
    new_stations(station)
    @interface.puts_result_station(true, @name)  #Станции нет, добавляем
  end

  def add_train  #2. Создать поезд
    @interface.puts_text(:num_train)
    @number = @interface.user_input.to_s
    return unless valid?(:train)
      @interface.puts_text(:choice_type)
      submenu = @interface.user_input.to_i
      case submenu
      when 1
        @train = PassengerTrain.new(@number)
        new_trains(@train)
        @interface.puts_pass_train(@number)
      when 2
        @train = CargoTrain.new(@number)
        new_trains(@train)
        @interface.puts_cargo_train(@number)
      else
        @interface.puts_text(:choice_back)
      end
  end

  def add_route  #3. Создать маршрут
    return unless valid?(:route_empty)
    show_stations
    @interface.puts_text(:choice_stations)
    @interface.puts_text(:first)
    @first_input = @interface.user_input.to_i - 1
    @interface.puts_text(:last)
    @last_input = @interface.user_input.to_i - 1
    return unless valid?(:route_same)
    @first = @stations[@first_input]
    @last = @stations[@last_input]
    return unless valid?(:route_both)
    @route = Route.new(@first, @last)
    new_routes(@route)
    @interface.puts_create_route(@route)
  end

  def add_station_to_route   #4. Добавить станцию к маршруту
    return unless check_route && check_station
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
    return unless check_route && check_station
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
    return unless check_train && check_route
    @get_route = @routes[@route_index]
    @get_train = @trains[@train_index]
    @get_train.set_route(@get_route)
    @interface.puts_route_to_train(@get_train, @route_index, @get_route)
  end

  def add_wagon_to_train   #7. Прицепить вагон к поезду
    return unless check_train
    get_train_type
    if @choice_type == :passenger
      wagon = PassengerWagon.new
      @choice_train.add_wagon(wagon)
      @interface.puts_add_pass_wagon(@choice_train)
    else
      wagon = CargoWagon.new
      @choice_train.add_wagon(wagon)
      @interface.puts_add_cargo_wagon(@choice_train)
    end
  end

  def delete_wagon_from_train   #8. Отцепить вагон от поезда
    return unless check_train
    get_train_type
    if @choice_train.wagons.count > 0
      wagon_id = @choice_train.wagons[-1]
      @choice_train.delete_wagon(wagon_id)
      @interface.puts_delete_wagon(true, @choice_train)
    else
      @interface.puts_delete_wagon(false, @choice_train)
    end
  end

  def move_forward   #9. Переместить поезд на станцию вперёд
    if @get_route == nil
      @interface.puts_text(:less_route)
      return
    end
    return unless check_train
    get_train_type
    if @choice_train.route == nil
      @interface.puts_text(:less_route)
      return
    end
    max = @choice_train.route.stations.size - 1
    index = @choice_train.index
    if index == max
      @interface.puts_end_station(@choice_train, index)
    else
      @choice_train.go_forward
      @interface.puts_move_forward_train(@choice_train, index)
    end
  end

  def move_backward   #10. Переместить поезд на пердыдущую станцию
    if @get_route == nil
      @interface.puts_text(:less_route)
      return
    end
    return unless check_train
    get_train_type
    if @choice_train.route == nil
      @interface.puts_text(:less_route)
      return
    end
    index = @choice_train.index
    if index != 0
      @choice_train.go_backward
      @interface.puts_move_backward_train(@choice_train, index)
    else
      @interface.puts_end_station(@choice_train, index)
    end
  end

  def show_stations  #11 Показать список станций
    return unless empty_station
    @interface.puts_text(:list_stations)
    @interface.puts_list_stations(@stations)
    @interface.puts_text(:divide)
    return true
  end

  def show_train_on_station  #12 Показать список поездов (на станции)
    return unless check_station
    if @stations[@station_index].list_train.empty?
      @interface.puts_on_station(false, @stations, @station_index)
    else
      @interface.puts_on_station(true, @stations, @station_index)
      get_trains = @stations[@station_index].list_train

      @interface.puts_list_trains(get_trains)

    end
  end

  def get_train_type
    @choice_train = @trains[@train_index]
    @choice_type = @choice_train.type
  end

  def check_route
    if @routes.empty?
      @interface.puts_text(:empty_routes)
      return
    end
    @interface.puts_text(:choice_route)
    @interface.puts_list_routes(@routes)
    @interface.puts_text(:divide)
    @route_index = @interface.user_input.to_i - 1
    unless @routes.include?(@routes[@route_index]) && @route_index >= 0
      @interface.puts_text(:choice_back)
      return
    end
    return true
  end

  def check_station
    return unless empty_station
    @interface.puts_text(:choice_station)
    show_stations
    @station_index = @interface.user_input.to_i - 1
    unless @stations.include?(@stations[@station_index]) && @station_index >= 0
      @interface.puts_text(:choice_back)
      return
    end
    return true
  end

  def check_train
    if @trains.empty?
      @interface.puts_text(:empty_train)
      return
    end
    @interface.puts_text(:choice_train)
    @interface.puts_list_trains(@trains)
    @interface.puts_text(:divide)
    @train_index = @interface.user_input.to_i - 1
    unless @trains.include?(@trains[@train_index]) && @train_index >= 0
      @interface.puts_text(:choice_back)
      return
    end
    return true
  end

  def empty_station
    if @stations.empty?
      @interface.puts_text(:empty_stations)
      return
    end
    return true
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
