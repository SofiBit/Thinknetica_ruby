require_relative 'modules/instance_counter'

class Route
  include InstanceCounter
  attr_accessor :start, :finish
  attr_reader :stations, :title

  def initialize(start, finish)
    @stations = [start, finish]
    validate!
    @title = "(#{start.title} - #{finish.title})"
    register_instance
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
    unless @stations.all?{|station| station.is_a?(Station)}
      raise "Object doesn't belong to the class Station."
    end
  end
end
