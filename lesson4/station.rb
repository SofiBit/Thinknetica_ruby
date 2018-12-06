# Documentation
class Station
  attr_reader :trains, :title

  def initialize(title)
    @title = title
    @trains = []
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
