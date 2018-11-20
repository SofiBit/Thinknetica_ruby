fibonacci = [0,1]

loop do
  break if fibonacci[-1] + fibonacci[-2] > 100
  fibonacci.push (fibonacci[-1] + fibonacci[-2])
end

puts fibonacci
