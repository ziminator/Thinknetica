# The validation module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :check_list

    def validate(name, type, *options)
      @check_list ||= {}
      @check_list[type] ||= []
      @check_list[type] << { name: name, options: options }
    end
  end

  module InstanceMethods
    def validate!
      self.class.check_list.each do |checking|
        attr = instance_variable_get("@#{checking[:name]}")
        send(checking[:type].to_sym, attr, checking[:options])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def presence(attr, args = {})
      if attr.is_a?(String) && attr.empty?
        raise 'Значение не должно быть пустым!'
      elsif attr.nil?
        raise 'Значение не существует!'
      end
    end

    def format(attr, args = {})
      raise 'Неверный формат!' if attr !~ args[:regexp]
    end

    def type(attr, args = {})
      raise 'Несовпадение класса!' unless attr.instance_of? args[:class]
    end
  end
end
