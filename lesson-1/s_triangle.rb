puts "Здравствуйте, я помогу расчитать площадь треугольника при известных размерах основания и высоты."
puts "Для расчёта введите пожалуйста основание треугольника:"
base = gets.chomp.to_f
puts "И введите пожалуйста высоту треугольника:"
height = gets.chomp.to_f
s = 0.5 * base * height
puts "Площадь треугольника равна #{s} кв.см."