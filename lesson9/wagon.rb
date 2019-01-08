require_relative 'modules/manufacturer'

class Wagon
  include Manufacturer
  attr_accessor :type, :number

  def initialize(type)
    @type = type.to_sym
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    return if %i[passenger cargo].include?(type)

    raise "Type must be 'passenger' or 'cargo'"
  end
end
