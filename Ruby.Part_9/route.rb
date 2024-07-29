# frozen_string_literal: true

require_relative 'modules'
require_relative 'station'

class Route
  include InstanceCounter

  attr_accessor :route

  def initialize(start, finish)
    @start = start
    @finish = finish
    @route = [0, 0]
    @route [0] = Station.find(start)
    @route [-1] = Station.find(finish)
    register_instance
  end

  def add_station(station)
    @route.insert(-2, Station.find(station))
  end

  def del_station(station)
    @route.delete(station)
  end

  def show_route
    puts 'Станции на маршруте:'
    @route.each { |x| puts x.title }
  end
end
