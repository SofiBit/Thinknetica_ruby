require_relative 'modules/instance_counter'

class Route
  include InstanceCounter
  attr_accessor :start, :finish
  attr_reader :stations, :title

  FORMAT_TITLE = /^[A-Z]{1}[a-z]+$/.freeze

  def initialize(start, finish)
    @stations = [start, finish]
    @title = "(#{start.title} - #{finish.title})"
    register_instance
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def delete_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise "Start must be like 'Minsk'." if start !~ FORMAT_TITLE
    raise "Finish must be like 'Minsk'." if finish !~ FORMAT_TITLE
  end
end
