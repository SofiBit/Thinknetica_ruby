puts "Enter Day, Month year"
day = gets.to_i
month = gets.to_i
year = gets.to_i

days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]

if ( year % 4 == 0 && year % 100 != 0 ) || year % 400 == 0
  days_in_month [1] = 29
end

sum_days = 0

for i in (0..(month-2))
  sum_days += days_in_month[i]
end

puts "Your day is #{sum_days.to_i + day} in a row"
