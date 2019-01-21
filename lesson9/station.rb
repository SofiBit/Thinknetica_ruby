require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Station
  include InstanceCounter
  include Validation

  validate :title, :type, String
  validate :title, :format, /^[A-Z]{1}[a-z]+$/

  attr_accessor :title
  attr_reader :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(title)
    @title = title
    @trains = []
    validate!
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

  def each_train
    @trains.each { |train| yield(train) }
  end
end
