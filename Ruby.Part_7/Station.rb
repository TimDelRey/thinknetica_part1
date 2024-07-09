require_relative 'modules'

class Station
  # когда у TRAIN назначается маршрут, его current_station заполняется каким то стэйшеном. 
  # Это значит, что у этого стэйшена должен заполнится (новый) хэш TRAINS_ON_STATION номер поезда => обьект поезда  
  # когда поезд меняет current_station - у старой стейшн из хэша TRAINS_ON_STATION должен удалитсья поезд, а у новой стэйшн - этот хэш пополнится

  include InstanceCounter

  def self.all
    @@all_stations
  end

  def self.find (station)
    @@all_stations[station]
  end

  attr_accessor :train_on_station, :stations_list, :title, :all_stations

  TITLE_FORMAT = /^[A-Z].+$/
  @@all_stations = {}

  def initialize (title)
    @title = title
    @train_on_station = {}
    @@all_stations [title] = self
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Введено невалидное название станции!" if @title !~ TITLE_FORMAT
    true
  end

  def each_train (&block)
    @train_on_station.values.each(&block)
  end
end

