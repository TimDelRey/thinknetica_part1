require_relative 'modules'

class Station

  include InstanceCounter

  def self.all
    @@all_stations
  end

  attr_writer :title

  TITLE_FORMAT = /^[A-Z].+$/
  @@all_stations =[]

  def initialize (title)
    @title = title
    @@all_stations << self
    register_instance
    validate!
  end

  def validate!
    raise "Введено невалидное название станции!" if @title !~ TITLE_FORMAT
    true
  end
end

