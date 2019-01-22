module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      name_sym = "@#{name}".to_sym
      name_history_sym = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(name_sym) }
      define_method("#{name}=") do |value|
        if instance_variable_get(name_history_sym).nil?
          instance_variable_set(name_history_sym, [])
        end

        instance_variable_get(name_history_sym).send :push, value

        instance_variable_set(name_sym, value)
      end

      define_method("#{name}_history") { instance_variable_get(name_history_sym) }
    end
  end

  def strong_attr_accessor(name, type)
    name_sym = "@#{name}".to_sym

    define_method(name) { instance_variable_get(name_sym) }
    define_method("#{name}=") do |value|
      unless value.class == type
        raise TypeError, "Type value of variable must be '#{type}'."
      end

      instance_variable_set(name_sym, value)
    end
  end
end
