puts "Здравствуйте, я могу определить тип треугольника по введённым значениям"
puts "Введите пожалуйста 1-ю сторону треугольника:"
n1 = gets.chomp.to_f
puts "Введите пожалуйста 2-ю сторону треугольника:"
n2 = gets.chomp.to_f
puts "Введите пожалуйста 3-ю сторону треугольника:"
n3 = gets.chomp.to_f

a, b, c = [n1, n2, n3].sort		        ##Получаем гипотенузу с через сортировку массива
rect = c**2 == a**2 + b**2            ##Определяем прямоугольность треугольника

if rect && (a == b)
  puts "Ваш треугольник прямоугольный и равнобедренный!"
elsif rect
  puts "Ваш треугольник прямоугольный!"
else
  puts "Обычный треугольник!"
end