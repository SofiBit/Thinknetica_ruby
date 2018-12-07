# Documentation
class CargoTrain < Train
  def initialize(number)
    @type = :cargo
    super(number, @type)
  end
end
