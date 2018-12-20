require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'trains/cargo_train'
require_relative 'trains/passenger_train'
require_relative 'wagon'
require_relative 'wagons/cargo_wagon'
require_relative 'wagons/passenger_wagon'

@stations = []
@trains = []
@routes = []

def main_menu
  loop do
    puts "
    ----------MAIN MENU----------
    1 - STATION MENU
    2 - TRAIN MENU
    3 - ROUTE MENU
    4 - LEAVE THE MENU
    "
    choice = gets.chomp.to_i
    break if choice == 4

    case_main_menu(choice)
  end
end

def case_main_menu(choice)
  case choice
  when 1 then station_menu
  when 2 then train_menu
  when 3 then route_menu
  else
    puts 'Enter the correct number.'
  end
end

# ----------STATION MENU---------
def station_menu
  loop do
    puts "
    ----------STATION MENU----------
    1 - CREATE STATION
    2 - VIEW STATION LIST
    3 - VIEW TRAIN LIST ON THE STATION
    4 - BACK TO THE MAIN MENU
    "
    choice = gets.chomp.to_i
    break if choice == 4

    case_station_menu(choice)
  end
end

def case_station_menu(choice)
  case choice
  when 1 then create_station
  when 2 then station_list
  when 3 then train_list_on_station
  else
    puts 'Enter the correct number.'
  end
end

def create_station
  loop do
    puts 'Enter a station name.'
    title = gets.chomp.to_s

    if station_in_stations?(title)
      puts 'Such station already exists.'
      break
    end

    begin
      @stations.push(Station.new(title))
      puts "You've created the new station: #{title}"
      break
    rescue StandardError
      puts 'Error. Enter suitable name station.'
    end
  end
end

def station_in_stations?(title)
  @stations.each { |station| return true if station.title == title }
  false
end

def station_list
  if @stations.empty?
    puts 'Station list is empty.'
  else
    puts 'Station list:'
    @stations.each { |station| puts station.title }
  end
end

def train_list_on_station
  if @stations.empty?
    puts 'There are not stations.'
    return
  end

  choose_station

  if @station.trains.empty?
    puts 'Train list is empty.'
  else
    puts 'Train list on station (number, type, quantity of wagons): '
    @station.each_train do |train|
      puts "#{train.number}, #{train.type}, #{train.wagons.size}."
    end
  end
end

def choose_station
  bool = true

  while bool
    puts 'Select and enter a station.'

    index_array = []

    @stations.each_with_index do |station, index|
      puts "Station #{station.title} - #{index + 1}"
      index_array << index + 1
    end

    choice = gets.chomp.to_i

    if index_array.include? choice
      bool = false
      @station = @stations[choice - 1]
    end
  end
end

# -----------TRAIN----------
def train_menu
  loop do
    puts "
      ----------TRAIN MENU---------
      1 - CREATE TRAIN
      2 - CHOOSE TRAIN
      3 - TRAIN LIST
      4 - BACK TO THE MAIN MENU
    "
    choice = gets.chomp.to_i
    break if choice == 4

    case_train_menu(choice)
  end
end

def case_train_menu(choice)
  case choice
  when 1 then create_train
  when 2 then selected_train
  when 3 then train_list
  else
    puts 'Enter the correct number.'
  end
end

def create_train
  loop do
    enter_train_number
    enter_train_type

    if train_in_trains?
      puts 'Error. Such train already exists.'
      break
    end

    begin
      @trains.push(Train.new(@number, @type))
      puts "You've created the new train: (#{@number}, #{@type})"
      break
    rescue StandardError
      puts 'Error. Enter valid data.'
    end
  end
end

def enter_train_number
  puts 'Enter a train number. Format: XXX(-/ )XX'
  @number = gets.chomp.to_s
end

def enter_train_type
  puts "Enter a train type: 'cargo' or 'passenger'."
  @type = gets.chomp.to_sym
end

def train_in_trains?
  @trains.each do |train|
    return true if train.number == @number && train.type == @type
  end
  false
end

def train_list
  return if trains_empty_print || trains_empty?

  @trains.each do |train|
    puts "Train: (#{train.number}, #{train.type})"
  end
end

def choose_train
  bool = true

  while bool
    puts 'Select and enter a train.'

    index_array = []

    @trains.each_with_index do |train, index|
      puts "Train (#{train.number}, #{train.type}) - #{index + 1}"
      index_array << index + 1
    end

    choice = gets.chomp.to_i

    next unless index_array.include? choice

    bool = false
    @train = @trains[choice - 1]
    puts "You've chosen train: (#{@train.number}, #{@train.type})!"
  end
end

def selected_train
  return if trains_empty_print || trains_empty?

  choose_train

  loop do
    puts "
    ---------OPERATIONS---------
    1 - APPOINT TO ROUTE
    2 - FORWARD/BACKWARDS
    3 - WAGON MENU
    4 - BACK
    "
    choice = gets.chomp.to_i
    break if choice == 4

    case_operations_train(choice)
  end
end

def case_operations_train(choice)
  case choice
  when 1 then appoint_route
  when 2 then forward_backwards
  when 3 then wagon_menu
  else
    puts 'Enter correct number.'
  end
end

def trains_empty?
  return true if @trains.empty?

  false
end

def trains_empty_print
  puts 'There are not a trains.' if trains_empty?
end

def appoint_route
  unless route_train?
    puts 'A route is already appointed.'
    return
  end

  if @routes.empty?
    puts "There aren't a routes."
    return
  end

  choose_route

  @train.route = @route
  puts "You've appointed the route!"
end

def forward_backwards
  if route_train?
    puts "Train havn't a route."
    return
  end

  loop do
    puts "
    1 - FORWARD
    2 - BACKWARDS
    3 - BACK
    "
    choice = gets.chomp.to_i
    break if choice == 3

    case_f_b(choice)
  end
end

def case_f_b(choice)
  case choice
  when 1
    @train.forward

    print "The train left the #{@train.previous_station.title} and "
    print "arrived on the #{@train.current_station.title}.\n"

  when 2
    @train.backwards

    print "The train left the '#{@train.next_station.title}' and "
    print "arrived on the '#{@train.current_station.title}'.\n"
  else
    puts 'Enter correct number.'
  end
end

def route_train?
  return true if @train.routes == []

  false
end

def wagon_menu
  loop do
    puts "
    ---------WAGON MENU--------
    1 - ADD WAGON
    2 - DELETE WAGON
    3 - VIEW WAGON LIST OF TRAIN
    4 - TAKE THE SEAT / TAKE UP THE VOLUME
    5 - BACK
    "

    choice = gets.chomp.to_i
    break if choice == 5

    case_wagon_menu(choice)
  end
end

def case_wagon_menu(choice)
  case choice
  when 1 then add_wagon
  when 2 then delete_wagon
  when 3 then list_wagon
  when 4 then choice_occupy
  else
    puts 'Enter correct number.'
  end
end

def add_wagon
  if @train.type == :passenger
    puts 'Enter quantity seats in wagon.'
    seats = gets.chomp.to_i

    @train.hook(PassengerWagon.new(seats))
    puts "You've added the new wagon: ('passenger', seats - #{seats})!"
  else
    puts 'Enter volume of wagon.'
    volume = gets.chomp.to_i

    @train.hook(CargoWagon.new(volume))
    puts "You've added the new wagon: ('cargo', volume - #{volume})!"
  end
end

def delete_wagon
  if @train.wagons.empty?
    puts "Train havn't a wagons."
    return
  end

  puts 'Select a wagon for deletion.'

  choose_wagon

  @train.unhook(@wagon)
  puts "You've deleted the wagon."
end

def choose_wagon
  bool = true

  while bool
    list_wagon

    puts 'Enter a number of wagon.'
    choice = gets.chomp.to_i

    if choice <= @train.wagons.size && choice > 0
      @wagon = @train.wagons[choice - 1]
      bool = false
    else
      puts 'Enter a correct number.'
    end
  end
end

def list_wagon
  if @train.wagons.empty?
    puts "Train havn't a wagons."
    return
  end

  if @train.type == :cargo
    train_type_cargo
  else
    train_type_passenger
  end
end

def train_type_cargo
  @train.each_wagon do |wagon|
    print "Number #{wagon.number}, "
    print "type #{wagon.type}, "
    print "free volume #{wagon.free}, "
    print "occupied volume #{wagon.occupied}.\n"
  end
end

def train_type_passenger
  @train.each_wagon do |wagon|
    print "Number #{wagon.number}, "
    print "type #{wagon.type}, "
    print "free seats #{wagon.free}, "
    print "occupied seats #{wagon.occupied}.\n"
  end
end

def choice_occupy
  return if @train.wagons.empty?

  puts 'Select a wagon.'

  choose_wagon

  if @wagon.type == :cargo
    occupy_cargo
  else
    occupy_passenger
  end
end

def occupy_cargo
  puts "Enter quantity volume.Free volume:#{@wagon.free}."
  quantity = gets.chomp.to_i

  if @wagon.free < quantity
    puts "You can't to occupy such the volume."
  else
    @wagon.to_occupy(quantity)
    puts "Free volume left: #{@wagon.free}."
  end
end

def occupy_passenger
  if @wagon.free > 0
    @wagon.to_occupy
    puts "You've took the seat! Free seats: #{@wagon.free}"
  else
    puts "You can't to take the seat. There isn't a free seats."
  end
end

# --------ROUTE--------
def route_menu
  loop do
    puts "
    ----------ROUTE----------
    1 - CREATE ROUTE
    2 - CHOOSE ROUTE
    3 - BACK TO THE MAIN MENU
    "
    choice = gets.chomp.to_i

    break if choice == 3

    case_route_menu(choice)
  end
end

def case_route_menu(choice)
  case choice
  when 1 then create_route
  when 2 then selected_route
  else
    puts 'Enter a correct number.'
  end
end

def create_route
  if @stations.empty?
    puts 'There are not stations to create a route.'
    return
  end

  puts 'First station:'
  choose_station
  start = @station

  puts 'Last station:'
  choose_station
  finish = @station

  puts "You've created a new route!"
  @routes.push(Route.new(start, finish))
end

def choose_route
  bool = true

  while bool
    puts 'Select and enter a route.'

    index_array = []

    @routes.each_with_index do |route, index|
      puts "Route #{route.title} - #{index + 1}"
      index_array << index + 1
    end

    choice = gets.chomp.to_i

    next unless index_array.include? choice

    bool = false
    @route = @routes[choice - 1]
    puts "You've chosen route: #{@route.title}!"
  end
end

def selected_route
  if @routes.empty?
    puts "There aren't a routes."
    return
  end

  loop do
    puts "
    ----------OPERATIONS---------
    1 - ADD STATION
    2 - DELETE STATION
    3 - VIEW STATIONS
    4 - BACK
    "
    choice = gets.chomp.to_i

    break if choice == 4

    case_operations_route(choice)
  end
end

def case_operations_route(choice)
  case choice
  when 1 then add_station
  when 2 then delete_station
  when 3 then route_list_stations
  else
    puts 'Enter correct number!'
  end
end

def add_station
  if @stations.empty?
    puts 'There are not stations.'
    return
  end

  choose_station

  @route.add_station(@station)
  puts "You've added station!"
end

def delete_station
  if @stations.empty?
    puts 'There are not stations'
    return
  end

  choose_station

  @route.delete_station(@station)
  puts "You've deleted station!"
end

def route_list_stations
  puts 'Stations:'
  @route.stations.each { |station| puts station.title }
end

main_menu
