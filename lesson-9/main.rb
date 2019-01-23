require_relative 'interface.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'instance_counter.rb'
require_relative 'fill_data.rb'

# General class main
class Main
  attr_reader :stations, :trains, :routes
  include InstanceCounter
  include FillData

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @number = nil
  end

  def run
    #data_create_stations
    #data_create_trains
    #data_add_wagons
    #data_add_routes
    #data_add_stations
    #data_set_routes
    @interface = Interface.new
    loop do
      @interface.menu
      choice = @interface.user_input.to_i
      case choice
      when 0 then exit                         # Exit
      when 1 then add_stations                 # Make a station
      when 2 then add_train                    # Make a train
      when 3 then add_route                    # Make a route
      when 4 then add_station_to_route         # Add station to the route
      when 5 then delete_station_from_route    # Remove stationsfrom the route
      when 6 then add_route_to_train           # Add route to train
      when 7 then add_wagon_to_train           # Add wagon to the train
      when 8 then delete_wagon_from_train      # Remove wagon from the train
      when 9 then move_forward                 # Move foreard
      when 10 then move_backward               # Move backward
      when 11 then show_stations               # Show list stations
      when 12 then show_train_on_station       # Train at the station
      when 13 then add_seat_volume             # Take a seat in passenger wagon
      when 14 then show_wagons                 # Take a peace of volume cargo
      when 15 then show_trains_on_stations     # Show all trains on all stations
      when 20 then test_station_objects        # Show object stations
      when 21 then test_find_objects           # Class find
      end
    end
  end

  private

  def test_station_objects
    @interface.puts_objects_stations
  end

  def test_find_objects
    Train.find(@number)
    @interface.puts_train_find(@number)
  end

  # 1 Make a station
  def add_stations
    @interface.puts_text(:station)
    name = @interface.user_input.to_s
    station = Station.new(name)
    new_stations(station)
    @interface.puts_result_station(true, name)
  rescue RuntimeError => station_exception
    @interface.puts_exception(station_exception)
    retry
  end

  # 2. Make a train
  def add_train
    @interface.puts_text(:num_train)
    @number = @interface.user_input.to_s
    @interface.puts_text(:choice_type)
    @submenu = @interface.user_input.to_i
    submenu_train
  rescue RuntimeError => train_exception
    @interface.puts_exception(train_exception)
    retry
  end

  def submenu_train
    case @submenu
    when 1
      new_passenger
    when 2
      new_cargo
    else
      @interface.puts_text(:choice_back)
    end
  end

  def new_passenger
    @train = PassengerTrain.new(@number)
    new_trains(@train)
    @interface.puts_pass_train(@number)
  end

  def new_cargo
    @train = CargoTrain.new(@number)
    new_trains(@train)
    @interface.puts_cargo_train(@number)
  end

  # 3. Make a route
  def add_route
    if @stations.empty? || @stations.count < 2
      @interface.puts_text(:empty_stations)
    else
      show_stations
      first_last
      new_route
    end
  rescue RuntimeError => route_exception
    @interface.puts_exception(route_exception)
    retry
  end

  def first_last
    @interface.puts_text(:choice_stations)
    @interface.puts_text(:first)
    first = @interface.user_input.to_i - 1
    @interface.puts_text(:last)
    last = @interface.user_input.to_i - 1
    @first = @stations[first]
    @last = @stations[last]
  end

  def new_route
    if @stations.include?(@first) && @stations.include?(@last)
      @route = Route.new(@first, @last)
      new_routes(@route)
      @interface.puts_create_route(@first, @last)
    else
      @interface.puts_text(:choice_back)
    end
  end

  # 4. Add station to route
  def add_station_to_route
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

  # 5. Remove station from route
  def delete_station_from_route
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

  # 6. Appoint route to train
  def add_route_to_train
    return unless check_train && check_route

    @get_route = @routes[@route_index]
    @get_train = @trains[@train_index]
    @get_train.set_route(@get_route)
    @interface.puts_route_to_train(@get_train, @route_index, @get_route)
  end

  # 7. Connect wagon to train
  def add_wagon_to_train
    return unless check_train

    get_train_type
    if @choice_type == :passenger
      @interface.puts_text(:seats)
      seats = @interface.user_input.to_i
      @wagon = PassengerWagon.new(seats)
      @choice_train.add_wagon(@wagon)
      @interface.puts_add_pass_wagon(@choice_train, seats)
    else
      @interface.puts_text(:volume)
      volume = @interface.user_input.to_i
      @wagon = CargoWagon.new(volume)
      @choice_train.add_wagon(@wagon)
      @interface.puts_add_cargo_wagon(@choice_train, volume)
    end
  end

  # 8. Remove wagon from train
  def delete_wagon_from_train
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

  # 9. Move train to next station
  def move_forward
    if @get_route.nil?
      @interface.puts_text(:less_route)
      return
    end
    return unless check_train

    get_train_type
    if @choice_train.route.nil?
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

  # 10. Move train to previou station
  def move_backward
    if @get_route.nil?
      @interface.puts_text(:less_route)
      return
    end
    return unless check_train

    get_train_type
    if @choice_train.route.nil?
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

  # 11 Show list stations
  def show_stations
    return unless empty_station

    @interface.puts_text(:list_stations)
    @interface.puts_list_stations(@stations)
    @interface.puts_text(:divide)
    true
  end

  # 12 Show list trains
  def show_train_on_station
    return unless check_station

    if @stations[@station_index].list_train.empty?
      @interface.puts_on_station(false, @stations, @station_index)
    else
      @interface.puts_on_station(true, @stations, @station_index)
      get_trains = @stations[@station_index].list_train
      @interface.puts_list_trains(get_trains)
    end
  end

  def show_wagons
    return unless check_train

    if get_train_type == :passenger
      @interface.puts_pass_wagons(@choice_train)
    else
      @interface.puts_cargo_wagons(@choice_train)
    end
  end

  def add_seat_volume
    show_wagons
    if get_train_type == :passenger
      @interface.puts_text(:wagon_seats)
      get_wagon
      return if @choice_train.wagons.count < @choice_wagon

      @get_wagon.fill
    else
      @interface.puts_text(:wagon_volume)
      get_wagon
      @interface.puts_text(:volume_busy)
      volume = @interface.user_input.to_i
      @get_wagon.fill(volume)
    end
  rescue RuntimeError => fill_exception
    @interface.puts_exception(fill_exception)
    retry
  end

  def get_wagon
    @choice_wagon = @interface.user_input.to_i
    @get_wagon = @choice_train.wagons[@choice_wagon - 1]
  end

  def add_volume
    return unless check_train

    @choice_train.fill
  end

  def get_train
    @choice_train = @trains[@train_index]
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
    true
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
    true
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
    true
  end

  def empty_station
    if @stations.empty?
      @interface.puts_text(:empty_stations)
      return
    end
    true
  end

  def show_trains_on_stations
    @stations.each_index do |st_index|
      @interface.puts_stations_trains(@stations[st_index].name)
      @stations[st_index].each_train do |train|
        @interface.puts_each_train(train)
        train.each_wagon do |wagon, w_index|
          @interface.puts_detail_wagons(wagon, w_index)
        end
        @interface.puts_text(:divide)
      end
    end
  end

  def new_stations(station)
    @stations << station
  end

  def new_routes(route)
    @routes << route
  end

  def new_trains(train)
    @trains << train
  end
end

main = Main.new
main.run
