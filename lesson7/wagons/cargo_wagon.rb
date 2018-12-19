# Documentation
class CargoWagon < Wagon
  attr_reader :overall_volume, :free, :occupied
  def initialize(overall_volume)
    @overall_volume = overall_volume.to_i
    @free = overall_volume.to_i
    @occupied = 0
    @type = :cargo
    super(type)
  end

  def to_occupy(quantity)
    if @free >= quantity
      @free -= quantity.to_i
      @occupied += quantity.to_i
    end
  end
end
