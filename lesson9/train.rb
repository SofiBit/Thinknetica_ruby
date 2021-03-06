require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze
  
  validate :number, :format, NUMBER_FORMAT

  attr_accessor :speed, :type, :number
  attr_reader :wagons, :route, :routes
  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number.to_s
    @type = type.to_sym
    @speed = 0
    @wagons = []
    @routes = []
    validate!
    @@trains[self.number] = self
    register_instance
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
    @wagons.each_with_index { |wagon_i, index| wagon_i.number = index + 1 }
  end

  def unhook(wagon)
    @wagons.delete(wagon) if speed.zero? && @wagons.include?(wagon)
    @wagons.each_with_index { |wagon_i, index| wagon_i.number = index + 1 }
  end

  def route=(route)
    @route = route
    @index_station = 0
    current_station.accept(self)
    @routes << route
  end

  def forward
    return unless next_station

    current_station.departure(self)
    @index_station += 1
    current_station.accept(self)
  end

  def backwards
    return unless previous_station

    current_station.departure(self)
    @index_station -= 1
    current_station.accept(self)
  end

  def next_station
    return if @index_station + 1 == @route.stations.count

    @route.stations[@index_station + 1]
  end

  def previous_station
    @route.stations[@index_station - 1] unless @index_station.zero?
  end

  def current_station
    @route.stations[@index_station]
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  protected

  def validate!
    return if %i[passenger cargo].include?(type)

    raise "Type must be 'passenger' or 'cargo'"
  end
end
