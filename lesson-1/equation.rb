puts "Я могу вычислить квадратное уравнение, для этого:"
puts "введите коэффициент a"
a = gets.chomp.to_f
puts "введите коэффициент в"
b = gets.chomp.to_f
puts "введите коэффициент с"
c = gets.chomp.to_f
d = b**2 - 4 * a * c
if d > 0
  d1 = Math.sqrt(d)
  x1 = (-b + d1) / (2 * a)
  x2 = (-b - d1) / (2 * a)
  puts "D = #{d}; X1 = #{x1}; X2 = #{x2}"
elsif d == 0
  x = -b / (2 * a)
  puts "D = #{d}; X = #{x} - корень один, т.к. корни равны."
else
  puts "D = #{d} Корней нет!"
end
