#Выделить меню в отдельный метод
def main_menu
  menu_items = <<-TEXT
    Выберите пункт меню:
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
    =======================================
  TEXT
  puts menu_items
  gets_menu
end

def gets_menu
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

