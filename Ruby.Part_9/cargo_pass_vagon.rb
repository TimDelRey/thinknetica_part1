# frozen_string_literal: true

require_relative 'modules'

class CargoVagon
  include Creater

  attr_reader :type, :name, :all_volume, :take_volume, :free_volume

  def initialize(name, all_volume, type = 'cargo', take_volume = 0)
    @name = name
    @type = type
    @all_volume = all_volume.to_i
    @take_volume = take_volume.to_i
    @free_volume = @all_volume
  end

  def fill_volume(volume)
    validate!
    raise 'Занимаемый объем больше объема вагона' if volume > @free_volume

    @take_volume += volume
    @free_volume = @all_volume - @take_volume
  end

  def validate!
    raise 'Был достигнут предел объема вагона' if @take_volume > @all_volume

    true
  end
end

class PassVagon
  include Creater

  attr_reader :type, :name, :all_seats, :take_seats, :free_seats

  def initialize(name, all_seats, type = 'pass', take_seats = 0)
    @name = name
    @type = type
    @all_seats = all_seats.to_i
    @take_seats = take_seats.to_i
    @free_seats = @all_seats
  end

  def take_place
    validate!
    @take_seats += 1
    @free_seats = @all_seats.-(@take_seats)
  end

  def validate!
    raise 'Свободные места закончились' if @take_seats >= @all_seats
  end
end
