=begin
Для грузовых вагонов:
Добавить атрибут общего объема (задается при создании вагона)
Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
Добавить метод, который возвращает занятый объем
Добавить метод, который возвращает оставшийся (доступный) объем
=end

class CargoWagon < Wagon

  def initialize(seats_volume)
    super(:cargo)
    @seats_volume = { free: seats_volume, busy: 0 }
    @total = seats_volume
    validate!
  end

  def validate!
    raise "Весь свободный объём занят!" if @seats_volume[:free] == 0
  end
end
