puts "Enter your name"
name = gets.chop

puts "Enter your height"
height = gets.to_i

if (height-110<0)
  puts "You have optimum weight"
else
  puts "#{name.capitalize}, your optimum weight is #{height-110}"
end
