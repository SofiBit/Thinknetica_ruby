load 'station.rb'
load 'route.rb'
load 'train.rb'

minsk = Station.new("Minsk")
borisov = Station.new("Borisov")
orsha = Station.new ("Orsha")
moscow = Station.new("Moscow")

route = Route.new (minsk),(moscow)

train_one = Train.new (1), ('passenger'),(10)
train_two = Train.new (2),('freight'),(18)

#test station

minsk.accept (train_one)
minsk.accept (train_two)

puts "After adding two trains #{minsk.trains}"

minsk.departure (train_two)

puts "After deletion the train 2 #{minsk.trains}"

puts "Passenger type trains: #{ minsk.trains_types ('passenger')},
      and title of the station: #{minsk.title}"

#test route

route.add_station (borisov)
route.add_station (orsha)

puts "Stations after adding two station : #{route.stations}"

route.delete_station (borisov)
route.delete_station (minsk)

puts "Stations after deletion Borisov and Minsk: #{route.stations}"

route.add_station (borisov)

#test train

train_one.speed = 60
train_one.increase_speed(40)
train_one.hook
puts "After increase speed on 40 (was 60): #{train_one.speed},
      Wagons after attempt hooking one (was 10): #{train_one.wagons}"
train_one.decrease_speed(120)
train_one.unhook
puts "After decrease speed on 120 (was 100): #{train_one.speed},
      Wagons after attempt unhooking (was 10): #{train_one.wagons}"


train_one.route = (route)
route.stations.each do |station|
  puts station.title
end

train_one.forward
train_one.forward
train_one.backwards
puts "Current station : #{train_one.current_station.title},
Next station: #{train_one.next_station.title},
Previous station : #{train_one.previous_station.title}"

train_one.backwards
puts "Previous station: #{train_one.previous_station}" #nill

puts "Type of train 1: #{train_one.type}"
