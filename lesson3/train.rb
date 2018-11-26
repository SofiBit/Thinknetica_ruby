class Train
  attr_accessor :speed
  attr_reader :wagons, :route, :type

  def initialize(number,type,wagons)
  @number = number
  @type = type
  @wagons = wagons
  @speed = 0
  end

  def increase_speed(s)
  @speed += s
  end

  def decrease_speed(s)
    if @speed - s > 0
      @speed -= s
    else
      @speed = 0
    end
  end

  def stop
  self.speed = 0
  end

  def hook
    @wagons += 1 if self.speed == 0
  end

  def unhook
    @wagons -= 1 if self.speed == 0
  end

  def route=(route)
    @route = route
    @index_station = 0
    current_station.accept(self)
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
    unless @index_station == 0
      @route.stations[@index_station - 1]
    end
  end

  def current_station
     @route.stations[@index_station]
  end
end
