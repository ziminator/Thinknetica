# The validation module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :check

    def validate(name, type, *params)
      self.check ||= {}
      self.check[name] ||= []
      self.check[name] << [type, params]
    end
  end

  module InstanceMethods
    def validate!
      self.class.check.each do |name, params|
        value = instance_variable_get("@#{name}")
        params.each do |val_params|
          send(val_params.first, value, val_params[1..-1])
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def presence(value, *args)
      raise 'Значение не должно быть пустым!' if value.empty? || value.nil?
    end

    def format(value, *args)
      format = args[0]
      raise 'Не верный формат!' if value !~ format
    end

    def type(value, *args)
      class_type = args[0]
      raise 'Несовпадение класса!' if value.class == class_type
    end
  end
end
