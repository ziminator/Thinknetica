basket = {}

total_price = 0
total_price_item = 0

loop do
  puts "Введите наименование товара или \"стоп\" для выхода:"
  name_goods = gets.chomp.to_s
  break if name_goods == "стоп"

  puts "Введите цену:"
  price_goods = gets.chomp.to_f

  puts "Введите количество:"
  qtty_goods = gets.chomp.to_f

  basket[name_goods] = { price: price_goods, qtty: qtty_goods }

end

puts basket

basket.each do | name, qtty_price |
  total_price_item = qtty_price[:price] * qtty_price[:qtty]
  total_price += total_price_item
  puts "#{name} => #{total_price_item}"
end

puts "Всего товаров в корзине на сумму: #{total_price}"
