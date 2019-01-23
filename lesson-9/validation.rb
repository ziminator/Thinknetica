# The validation module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :check_list

    def validate(name, type, params = {})
      @check_list ||= []
      @check_list << { name: name, type: type, param: params }
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
      if attr.is_a? String
        raise 'Значение не должно быть пустым!' if attr.empty?
      else
        raise 'Значение не существует!' if attr.nil?
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
