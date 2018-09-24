puts "Введите число:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  days[1] = 29
end

day_total = 0
i = 0

while i < month
  day_total += days[i]
  i += 1
end

day_total += day

puts day_total
