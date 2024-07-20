# frozen_string_literal: true

require_relative 'modules'
require_relative 'cargo_pass_vagon'

class Train
  include Creater
  include InstanceCounter

  def self.find(name)
    @@all_trains[name]
  end

  attr_reader :number, :vagon, :cargo_train, :pass_train, :all_vagons, :current_station, :speed, :direction, :position_next, :position_back
  attr_accessor :type

  @@all_trains = {}
  TRAIN_NUMBER_FORMAT = /[a-z0-9]{3}(-)?[a-z0-9]{2}/i.freeze

  def initialize(number, current_station = 'не назначен')
    @number = number
    @type = type
    @cargo_train = {}
    @pass_train = {}
    @current_station = current_station
    @direction = direction
    @all_vagons = []
    @@all_trains[number] = self
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise 'Неверный формат номера!' if @number !~ TRAIN_NUMBER_FORMAT

    true
  end

  def add_vagon(vagon)
    @cargo_train[vagon.name] = vagon if type == 'cargo' && vagon.type
    @pass_train[vagon.name] = vagon if type == 'pass' && vagon.type
  end

  def delete_vagon(vagon)
    @cargo_train.delete(vagon)
    @pass_train.delete(vagon)
  end

  def add_direction(direction)
    @direction = direction
    @current_station = direction.route[0]
    direction.route[0].train_on_station[number] = self # добавление поезда на станцию
  end

  def station_forward
    @position_now = @direction.route.index(@current_station)
    @current_station = @direction.route[@position_now + 1]
    @direction.route[@position_now].train_on_station.delete(number)
    @direction.route[@position_now + 1].train_on_station[number] = self
  end

  def station_back
    @position_now = @direction.route.index(@current_station)
    @current_station = @direction.route[@position_now - 1]
    @direction.route[@position_now].train_on_station.delete(number)
    @direction.route[@position_now - 1].train_on_station[number] = self
  end

  def each_vagon(&block)
    @all_vagons = @pass_train.values + @cargo_train.values
    @all_vagons.each(&block)
  end
end
