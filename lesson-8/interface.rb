# Include module
require_relative 'instance_counter.rb'

# Interface class
class Interface
  TEXT_CONST = {
    station: 'Введите название станции:',
    num_train: 'Введите номер поезда в формте - XXX-XX (номер может
      состоять из любых символов, дефис необязателен)',
    choice_train: 'Введите индекс поезда:',
    choice_route: 'Выберите индекс маршрута:',
    choice_station: 'Выберите индекс станции из списка,',
    choice_type: 'Выберите тип поезда: 1 - Пассажирский; 2 - Товарный',
    choice_stations: 'Выберите из списка индекс станции,',
    choice_back: 'Вы сделали неверный выбор, повторите ещё раз!',
    list_stations: 'Список станций:',
    divide: '-------------------',
    first: 'Начальная:',
    last: 'Конечная:',
    first_last: 'Первая и последняя станция не могут быть одинаковыми!',
    non_stations: 'Выбраны несуществующие станции!',
    empty_stations: 'Cначала добавьте станции!',
    empty_train: 'Нет поездов для выбора, добавьте хотя бы один поезд!',
    empty_routes: 'Нет маршрутов для выбора, сначала добавьте
      хотя бы один маршрут!',
    print_back: 'Вы ввели неверные данные, повторите ещё раз!',
    less_station: 'Одной станции для построения маршрута недостаточно!
      Добавьте ещё хотя бы одну станцию!',
    less_route: 'У поезда отсутствуют назначенные маршруты!
      Сначала назначте маршрут поезду!',
    seats: 'Введите кол-во мест в вагоне (максимум 99):',
    volume: 'Введите общий объём вагона:',
    wagon_seats: 'Чтобы занять место в вагоне, введите номер вагона:',
    wagon_volume: 'Чтобы занять объём, введите номер вагона',
    volume_busy: 'Введите значение объёма, который необходимо занять
      в вагоне'
  }

  def menu
    menu_items = <<-TEXT
      Выберите пункт меню:
      =======================================================================
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

      Служебное меню:
      =======================================================================
      13  - Операции с вагонами
      14  - Подробная информацию о вагонах
      15  - Отобразить все поезда на всех станциях
      20  - Посмотреть объекты станций
      21  - Посмотреть объекты поездов
      _______________________________________________________________________
      0   - ВЫХОД
      =======================================================================
    TEXT
    puts menu_items
  end

  def puts_text(text)
    case text
    when :station then puts TEXT_CONST[:station]
    when :num_train then puts TEXT_CONST[:num_train]
    when :choice_type then puts TEXT_CONST[:choice_type]
    when :choice_stations then puts TEXT_CONST[:choice_stations]
    when :list_stations then puts TEXT_CONST[:list_stations]
    when :divide then puts TEXT_CONST[:divide]
    when :first then puts TEXT_CONST[:first]
    when :last then puts TEXT_CONST[:last]
    when :first_last then puts TEXT_CONST[:first_last]
    when :choice_route then puts TEXT_CONST[:choice_route]
    when :choice_station then puts TEXT_CONST[:choice_station]
    when :choice_train then puts TEXT_CONST[:choice_train]
    when :empty_stations then puts TEXT_CONST[:empty_stations]
    when :empty_train then puts TEXT_CONST[:empty_train]
    when :empty_routes then puts TEXT_CONST[:empty_routes]
    when :choice_back then puts TEXT_CONST[:choice_back]
    when :print_back then puts TEXT_CONST[:print_back]
    when :less_station then puts TEXT_CONST[:less_station]
    when :less_route then puts TEXT_CONST[:less_route]
    when :seats then puts TEXT_CONST[:seats]
    when :volume then puts TEXT_CONST[:volume]
    when :wagon_seats then puts TEXT_CONST[:wagon_seats]
    when :wagon_volume then puts TEXT_CONST[:wagon_volume]
    when :volume_busy then puts TEXT_CONST[:volume_busy]
    end
  end

  def puts_exception(exception)
    puts exception
  end

  def puts_objects_stations
    puts "Список объектов созданных станций #{Station.all}"
  end

  def puts_train_find(number)
    puts "Объект поезда #{Train.find(number)}"
  end

  def puts_result_station(bool, name)
    if bool
      puts "Станция #{name} создана!"
    else
      puts "Станция #{name} уже есть, введите другое название станции!"
    end
  end

  def puts_station_to_route(bool, station)
    if bool
      puts "Станция #{station.name} добавлена в маршрут."
    else
      puts "Станция #{station.name} уже есть в маршруте, " \
      "выберите другую станцию!"
    end
  end

  def puts_delete_from_route(bool, station)
    if bool
      puts "Станция #{station.name} удалена из маршрута."
    else
      puts "Станции #{station.name} нет в маршруте, выберите другую станцию!"
    end
  end

  def puts_on_station(bool, station, index)
    if bool
      puts "На станции #{station[index].name} находятся:"
    else
      puts "На станции #{station[index].name} нет поездов."
    end
  end

  def puts_delete_wagon(bool, train)
    if bool
      puts "От поезда № - #{train.number} отцепили вагон, осталось " \
      "вагонов #{train.wagons.count}"
    else
      puts "У поезда № - #{train.number} пока нет ни одного вагона!"
    end
  end

  def puts_pass_train(number)
    puts "Создан пассажирский поезд №-#{number}"
  end

  def puts_cargo_train(number)
    puts "Создан товарный поезд №-#{number}"
  end

  def puts_double_train(number)
    puts "Поезд с номером #{number} уже есть, введите другой номер поезда!"
  end

  def puts_create_route(first, last)
    puts "Создан маршрут #{first.name} --- #{last.name}"
  end

  def puts_route_to_train(train, route_index, get_route)
    puts "Поезду с № - #{train.number} назначен маршрут № #{route_index + 1}." \
    " #{get_route.first.name} - #{get_route.last.name}"
  end

  def puts_end_station(train, index)
    puts "Поезд #{train.number} находится на конечной станции" \
    " #{train.route.stations[index].name}!"
  end

  def puts_move_forward_train(train, index)
    puts "Поезд #{train.number} отправляется со станции" \
    " #{train.route.stations[index].name} на станцию" \
    " #{train.route.stations[index + 1].name}."
  end

  def puts_move_backward_train(train, index)
    puts "Поезд #{train.number} отправляется со станции" \
    " #{train.route.stations[index].name} на станцию" \
    " #{train.route.stations[index - 1].name}."
  end

  def puts_add_pass_wagon(train, seats)
    puts "К поезду № - #{train.number} добавлен пассажирский вагон," \
    " свободных мест - #{seats}. Всего добавлено вагонов #{train.wagons.count}."
  end

  def puts_add_cargo_wagon(train, volume)
    puts "К поезду № - #{train.number} добавлен товарный вагон общим объёмом" \
    " - #{volume}. Всего добавлено вагонов #{train.wagons.count}"
  end

  def puts_pass_wagons(train)
    train.wagons.each.with_index(1) { |train, index|  puts "В вагоне № - " \
    "#{index}: всего мест-#{train.total}, свободных мест-#{train.free}," \
    " занято мест-#{train.busy}" }
  end

  def puts_cargo_wagons(train)
    train.wagons.each.with_index(1) { |train, index|  puts "Вагон № - " \
    "#{index}: общий объём-#{train.total}, свободный объём вагона-" \
    "#{train.free}, занятый объём вагона-#{train.busy}" }
  end

  def puts_list_stations(stations)
    stations.each.with_index(1) { |station, index| puts "#{index} - " \
    "#{station.name} "}
  end

  def puts_list_trains(trains)
    trains.each.with_index(1) { |train, index| puts "#{index}: " \
    "Поезд № #{train.number}, тип - #{train.type}" }
  end

  def puts_list_routes(routes)
    routes.each.with_index(1) { |route, index| puts "#{index}: " \
    "#{route.stations.map(&:name)}" }
  end

  def puts_stations_trains(station)
    puts "На станции #{station} находятся поезда:"
  end

  def puts_each_train(train)
    if train.type == :passenger
      puts "Поезд №: #{train.number}, тип: \"Пассажирский\", " \
      "вагонов #{train.wagons.count}"
    else
      puts "Поезд №: #{train.number}, тип: \"Товарный\", " \
      "вагонов #{train.wagons.count}"
    end
  end

  def puts_detail_wagons(wagon, index)
    if wagon.type == :passenger
      puts "Вагон № #{index}, тип \"Пассажирский\" -- всего мест: " \
      "#{wagon.total}, мест свободно: #{wagon.free}, мест занято: #{wagon.busy}"
    else
      puts "Вагон № #{index}, тип \"Товарный\"-- всего объём вагона: " \
      "#{wagon.total}, свободный объём: #{wagon.free}, " \
      "занятый объём: #{wagon.busy}"
    end
  end

  def user_input
    gets.chomp
  end
end
