# Documentation
class PassengerWagon < Wagon
  attr_reader :seats, :occupied, :free
  def initialize(seats)
    @seats = seats.to_i
    @free = seats.to_i
    @occupied = 0
    @type = :passenger
    super(type)
  end

  def to_occupy
    return unless @free > 0

    @free -= 1
    @occupied += 1
  end
end
