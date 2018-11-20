hash = {}

loop do
  puts "Enter the product's name "
  product = gets.chomp.to_s
  break if product == "stop"
  puts "Enter price of product"
  price = gets.chomp
  puts "How many products?"
  quantity = gets.chomp.to_i

  hash [product] = { quantity: quantity, price: price.to_f }
end

puts hash

sum = 0
hash.each do |product,quantity_price|
 product_price = quantity_price[:quantity] * quantity_price[:price]
 puts "total amount for #{product}: #{product_price}"
 sum += product_price
end

puts "Your purchase amount is #{sum}"
