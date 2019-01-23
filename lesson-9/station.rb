require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

# Class station
class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :name

  @@stations = []

  validate :name, :presence

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def each_train
    return unless block_given?

    @trains.each { |train| yield(train) }
  end

  # Getting trains
  def add_train(train)
    @trains << train
  end

  # Trains on stations
  def list_train
    @trains
  end

  # List trains by type
  def type_train(type)
    @trains.select { |train| train.type == type }
  end

  def left_train(train)
    @trains.delete(train)
  end
end
