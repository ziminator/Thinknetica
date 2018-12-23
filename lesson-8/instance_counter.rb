# Class couter module
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class method
  module ClassMethods
    attr_accessor :counter
    def instances
      self.counter ||= 0
    end
  end

  # Instance method
  module InstanceMethods
    private

    def register_instance
      self.class.counter ||= 0
      self.class.counter += 1
    end
  end
end
