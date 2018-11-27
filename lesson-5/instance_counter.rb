module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :counter
    def instances
      self.counter ||= 0
    end
  end

  module InstanceMethods
    private
    def register_instance
      self.class.counter += 1
    end
  end
end

