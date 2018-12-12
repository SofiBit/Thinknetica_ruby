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

    case choice
    when 1
      station_menu
    when 2
      train_menu
    when 3
      route_menu
    when 4
      break
    else
      puts 'Enter the correct number.'
    end
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

    case choice

    when 1
      create_station
    when 2
      station_list
    when 3
      train_list_on_station
    when 4
      return
    else
      puts 'Enter the correct number.'
    end
  end
end

def create_station
  bool = true

  while bool
    puts 'Enter a station name.'
    title = gets.chomp.to_s

    if station_in_stations?(title)
      puts 'Such station already exists.'
      break
    end

    begin
      @stations.push(Station.new(title))
      puts "You've created the new station: #{title}"
      bool = false
    rescue
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
    puts 'Train list is empty'
  else
    puts 'Train list on station: '
    @station.trains.each { |train| puts "(#{train.number}, #{train.type})" }
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

    case choice
    when 1
      create_train
    when 2
      selected_train
    when 3
      train_list
    when 4
      return
    else
      puts 'Enter the correct number.'
    end
  end
end

def create_train
  bool = true

  while bool
    puts 'Enter a train number. Format: XXX(-/ )XX'
    number = gets.chomp.to_s

    puts "Enter a train type: 'cargo' or 'passenger'."
    type = gets.chomp.to_sym

    if train_in_trains?(number, type)
      puts 'Error. Such train already exists.'
      break
    end

    begin
      @trains.push(Train.new(number, type))
      puts "You've created the new train: (#{number}, #{type})"
      bool = false
    rescue
      puts 'Error. Enter valid data.'
    end
  end
end

def train_in_trains?(number, type)
  @trains.each do |train|
    return true if train.number == number && train.type == type
  end
  false
end

def train_list
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
  if @trains.empty?
    puts "There aren't trains."
    return
  end

  choose_train

  loop do
    puts "
    ---------OPERATIONS---------
    1 - APPOINT TO ROUTE
    2 - FORWARD/BACKWARDS
    3 - ADD/DELETE WAGON
    4 - BACK
    "
    choice = gets.chomp.to_i

    case choice
    when 1
      appoint_route
    when 2
      forward_backwards
    when 3
      wagons
    when 4
      break
    else
      puts 'Enter correct number.'
    end
  end
end

def appoint_route
  unless route_train?
    puts 'A route is already appointed.'
    return
  end

  return if choose_route

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

    case choice
    when 1
      @train.forward

      puts "
      The train left the #{@train.previous_station.title},
      arrived on the #{@train.current_station.title}.
      "
    when 2
      @train.backwards

      puts "
      The train left the #{@train.next_station.title},
      arrived on the #{@train.current_station.title}.
      "
    when 3
      break
    else
      puts 'Enter correct number.'
    end
  end
end

def route_train?
  return true if @train.routes == []

  false
end

def wagons
  loop do
    puts "
    1 - ADD WAGON
    2 - DELETE WAGON
    3 - BACK
    "
    choice = gets.chomp.to_i
    case choice
    when 1
      if @train.type == :passenger
        @train.hook(PassengerWagon.new)
        puts 'Wagon added!'
      elsif @train.type == :cargo
        @train.hook(CargoWagon.new)
        puts 'Wagon added!'
      end
    when 2
      if @train.type == :passenger
        @train.unhook(PassengerWagon.new)
        puts 'Wagon deleted!'
      elsif @train.type == :cargo
        @train.unhook(CargoWagon.new)
        puts 'Wagon deleted!'
      end
    when 3
      break
    else
      puts 'Enter correct number!'
    end
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

    case choice
    when 1
      create_route
    when 2
      selected_route
    when 3
      break
    else
      puts 'Enter correct number.'
    end
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
  if @routes.empty?
    puts "There aren't routes."
    return true
  end

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
  false
end

def selected_route
  return if choose_route

  loop do
    puts "
    ----------OPERATIONS---------
    1 - ADD STATION
    2 - DELETE STATION
    3 - VIEW STATIONS
    4 - BACK
    "
    choice = gets.chomp.to_i

    case choice
    when 1
      add_station
    when 2
      delete_station
    when 3
      route_list_stations
    when 4
      break
    else
      puts 'Enter correct number!'
    end
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
