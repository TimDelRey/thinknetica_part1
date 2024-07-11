require_relative 'modules'
require_relative 'Station'

class Route

  include InstanceCounter 

  attr_accessor :route
  def initialize (start, finish)
    @start = start
    @finish = finish
    @route = [0,0]
    @route [0] = Station.find(start)
    @route [-1] = Station.find(finish)
    register_instance
    # validate!
  end

  # def valid?
  #   validate!
  # rescue
  #   false
  # end


  # def validate!
  #   raise "AAAAAAAAAAAA" unless @@all_stations.include?(self.route)
  #   # raise "AAAAAAAAAAAA" if @@all_stations.include?(self.finish) == false
  #   true
  # end

  def add_station (station)
    @route.insert(-2, Station.find(station))
  end

  def del_station (station)
    @route.delete(station)
  end

  def show_route
    puts "Станции на маршруте:"
    @route.keys
  end
end