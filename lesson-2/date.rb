puts "Введите число:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

days.each_with_index { |d, m| day += d if month - 1 > m }

if ( year % 4 == 0 && year % 100 != 0 || year % 400 == 0 ) && ( month > 2 && day > 28)
  day += 1
end

puts day
