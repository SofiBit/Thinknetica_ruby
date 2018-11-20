puts "Enter triangle sides a,b,c"
a = gets.to_f
b = gets.to_f
c = gets.to_f
if (a == b && b == c)
  puts "equilateral triangle and isosceles triangle, but"
elsif (a == b || b == c || a == c)
  puts "isosceles triangle"
end

if (a > b && a > c)
  hipotenuse = a
  leg1 = b
  leg2 = c
elsif (b > a && b > c)
  hipotenuse = b
  leg1 = a
  leg2 = c
else
   hipotenuse = c
   leg1 = a
   leg2 = b
end

if(hipotenuse ** 2 == leg1 ** 2 + leg2 ** 2)
  puts "right triangle"
else
  puts "not right triangle"
end
