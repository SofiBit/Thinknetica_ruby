calendar = { January: 31, February: 28, March: 31, April: 30, May: 31, June: 30,
   July: 31, August: 30, Septemper: 31, October: 30, November: 31, December: 30,}
calendar.each do |month,days|
  if days == 30
    puts month
  end
end
