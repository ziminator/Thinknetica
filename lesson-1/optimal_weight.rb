puts "Здравствуйте, я программа определяющая оптимальный вес."
puts "Представьтесь пожалуйта, как Вас зовут?"
name = gets.chomp
puts "Ваш рост?"
height = gets.chomp.to_i
weight = height - 110
if weight < 0
  puts "#{name}, Ваш вес уже оптимальный!"
else
  puts "#{name}, Ваш оптимальный вес #{weight} кг!"
end
