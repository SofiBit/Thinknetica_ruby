# Documentation
class Route
  attr_reader :stations, :title

  def initialize(start, finish)
    @stations = [start, finish]
    @title = "(#{start.title} - #{finish.title})"
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def delete_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end
end
