require_relative 'modules/instance_counter'

class Station
  include InstanceCounter
  attr_reader :trains, :title

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(title)
    @title = title
    @trains = []
    @@stations << self
    register_instance
  end

  def accept(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def trains_types(type)
    @trains.select { |train| train.type == type }
  end
end
