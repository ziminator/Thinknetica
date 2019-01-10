module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      name_method = "@#{name}".to_sym
      define_method(name) { instance_variable_get(name_method) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(name_method, value)
        @method_history ||= {}
        @method_history[name] ||= []
        @method_history[name] << value
      end
      define_method("#{name}_history") { @history[name] }
    end
  end

  def strong_attr_accessor(name_attr, name_class)
    name_method = "@#{name_attr}".to_sym
    define_method(name_attr) { instance_variable_get(name_method) }

    define_method("#{name_attr}=".to_sym) do |value|
      raise 'Неверный тип!' if value.is_a?(name_class)
      instance_variable_set(name_method, value)
    end
  end
end


