require_relative 'modules/instance_counter'

class Station
  include InstanceCounter

  attr_accessor :title
  attr_reader :trains

  FORMAT_TITLE = /^[A-Z]{1}[a-z]+$/.freeze

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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise "Title must be like 'Minsk'" if title !~ FORMAT_TITLE
  end
end
