# Documentation
class Train
  attr_accessor :speed
  attr_reader :wagons, :route, :type, :number, :routes

  def initialize(number, type)
    @number = number
    @type = type.to_sym
    @speed = 0
    @wagons = []
    @routes = []
  end

  def increase_speed(increase)
    @speed += increase
  end

  def decrease_speed(decrease)
    if @speed - decrease > 0
      @speed -= decrease
    else
      @speed = 0
    end
  end

  def stop
    self.speed = 0
  end

  def hook(wagon)
    @wagons << wagon if speed.zero? && wagon.type == type
  end

  def unhook(wagon)
    @wagons.delete(wagon) if speed.zero? && @wagons.include?(wagon)
  end

  def route=(route)
    @route = route
    @index_station = 0
    current_station.accept(self)
    @routes << route
  end

  def forward
    if next_station
      current_station.departure(self)
      @index_station += 1
      current_station.accept(self)
    end
  end

  def backwards
    if previous_station
      current_station.departure(self)
      @index_station -= 1
      current_station.accept(self)
    end
  end

  def next_station
    unless @index_station + 1 == @route.stations.count
      @route.stations[@index_station + 1]
    end
  end

  def previous_station
    @route.stations[@index_station - 1] unless @index_station.zero?
  end

  def current_station
    @route.stations[@index_station]
  end
end
