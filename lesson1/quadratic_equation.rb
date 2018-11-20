puts "Enter a,b,c for ax^2+bx+c"
a = gets.to_f
b = gets.to_f
c = gets.to_f

if (a == 0)
  puts "Not a quadratic equation"
  exit (a)
end

d = (b ** 2 - 4 * a * c)
if (d > 0)
  d = Math.sqrt(d)
  x1 = ( - b + d) / (2 * a)
  x2 = ( - b - d) / (2 * a)
  puts "First root is #{x1}, Second root is #{x2}"
elsif (d == 0)
  x1 = - b / (2 * a)
  puts "Root is #{x1}"
else
  puts "No roots"
end
