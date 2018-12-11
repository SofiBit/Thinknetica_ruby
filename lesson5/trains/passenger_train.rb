# Documentation
class PassengerTrain < Train
  def initialize(number)
    @type = :passenger
    super(number, @type)
  end
end
