=begin
Для пассажирских вагонов:
Добавить атрибут общего кол-ва мест (задается при создании вагона)
Добавить метод, который "занимает места" в вагоне (по одному за раз)
Добавить метод, который возвращает кол-во занятых мест в вагоне
Добавить метод, возвращающий кол-во свободных мест в вагоне.
=end

class PassengerWagon < Wagon

  def initialize(seats_volume)
    super(:passenger)
    @seats_volume = { free: seats_volume, busy: 0 }
    @total = seats_volume
    validate!
  end

  def validate!
    raise "Все свободные места заняты!" if @seats_volume[:free] == 0
  end
end
