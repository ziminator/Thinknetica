module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      variable_name = "@#{name}".to_sym
      history_var = "@history_#{name}".to_sym

      define_method(name) { instance_variable_get(variable_name) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(variable_name, value)
        instance_variable_set(history_var, []) unless \
        instance_variable_get(history_var)
        instance_variable_set(history_var) << value
      end
      define_method("#{name}_history") \
      { instance_variable_get("@history_#{name}".to_sym) }
    end
  end

  def strong_attr_accessor(name_attr, name_class)
    variable_name = "@#{name_attr}".to_sym
    define_method(name_attr) { instance_variable_get(variable_name) }

    define_method("#{name_attr}=".to_sym) do |value|
      raise 'Неверный тип!' unless value.instance_of?(name_class)
      instance_variable_set(variable_name, value)
    end
  end
end


