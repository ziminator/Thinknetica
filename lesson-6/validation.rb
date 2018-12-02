module Validation

  NUMBER_TRAIN = /^[\D\d]{3}-?[\D\d]{2}$/i

  def valid?(key)
    case key
    when :station
      raise @interface.puts_text(:print_back) if @name.empty?
      raise @interface.puts_result_station(false, @name) if @stations.map(&:name).include? @name
    when :train
      raise @interface.puts_text(:mismatch_number) if @number !~ NUMBER_TRAIN
      raise @interface.puts_text(:print_back) if @number == nil or @number == ""
      raise @interface.puts_double_train(@number) if @trains.map(&:number).include? @number
    when :route_empty
      raise @interface.puts_text(:empty_stations) if @stations.empty? || @stations.count < 2
    when :route_same
      raise @interface.puts_text(:first_last) if @first_input == @last_input
    when :route_both
      raise @interface.puts_text(:choice_back) unless @stations.include?(@first) && @stations.include?(@last)
    end
    true
  rescue
    false
  end
end
