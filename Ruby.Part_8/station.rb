# frozen_string_literal: true

require_relative 'modules'

class Station
  include InstanceCounter

  def self.all
    @@all_stations
  end

  def self.find(station)
    @@all_stations[station]
  end

  attr_accessor :train_on_station, :title, :all_stations

  TITLE_FORMAT = /^[A-Z].+$/.freeze
  @@all_stations = {}

  def initialize(title)
    @title = title
    @train_on_station = {}
    @@all_stations [title] = self
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise 'Введено невалидное название станции!' if @title !~ TITLE_FORMAT

    true
  end

  def each_train(&block)
    @train_on_station.values.each(&block)
  end
end
