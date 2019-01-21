module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate_data
      @validate_data ||= []
    end

    def validate(name, type_valid, param = nil)
      unless %i[prensence format type].include?(type_valid)
        raise 'Invalid validation type'
      end

      validate_data << { name: name, type_valid: type_valid, param: param }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validate_data.each do |value|
        name = value[:name]
        name_value = instance_variable_get("@#{name}".to_sym)

        send("#{value[:type_valid]}", name_value, value[:param])
      end
    end

    def prensence(name, _param)
      return unless name.nil || name.to_s.empty?

      raise "Value of variable mustn't be 'nil' or empty!"
    end

    def format(name, format_param)
      return unless name !~ format_param

      raise "Value of variable must be of such format '#{format_param}'!"
    end

    def type(name, type_param)
      return if name.class == type_param

      raise "Value of variable must be '#{type_param}'!"
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end
