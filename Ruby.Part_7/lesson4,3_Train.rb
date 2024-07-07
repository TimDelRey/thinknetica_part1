require_relative 'modules'


class Train


  include Creater
  include InstanceCounter

  def self.find(name)
    @@all_trains[name]
    
  end

  attr_reader :number, :vagon, :cargo_train, :pass_train, :all_vagons, :current_station, :speed, :direction
  attr_accessor :type

  @@all_trains = {}
  TRAIN_NUMBER_FORMAT = /[a-z0-9]{3}(-)?[a-z0-9]{2}/i

  def initialize (number, speed = 0, current_station = "не назначен")
    @speed = speed
    @number = number
    @type = type
    @cargo_train = {}
    @pass_train = {}
    @current_station = current_station
    @direction = direction
    @@all_trains[number] = self
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Неверный формат номера!" if @number !~ TRAIN_NUMBER_FORMAT
    raise "Скорость #{@speed} должна выражаться в цифрах" if @speed.class != Integer
    true
  end

  def add_vagon (vagon)
    if self.type == "cargo" && vagon.type == self.type
      @cargo_train[vagon.name] = vagon   
    end
    if self.type == "pass" && vagon.type == self.type
      @pass_train[vagon.name] = vagon
    end 
  end

  def delete_vagon (vagon)
    @cargo_train.delete (vagon.name) 
    @pass_train.delete (vagon.name)
  end 

  def set_speed (speed)
    @speed = speed
    validate!
  end

  def speed
    @speed
  end

  def stop
    @speed = 0
  end
  #Может прицеплять/отцеплять вагоны (по одному вагону за 
  #операцию, метод просто увеличивает или уменьшает количество 
  #вагонов). Прицепка/отцепка вагонов может осуществляться 
  #только если поезд не движется.
  def change_vagon (change)
    if @speed == 0
      @vagon+=1 if change == "+1"
      @vagon-=1 if change == "-1"
    else puts "Для изменения вагонов,необходимо остановится"
    end
  end
  #Может принимать маршрут следования (объект класса Route). 
  #При назначении маршрута поезду, поезд автоматически 
  #помещается на первую станцию в маршруте.
  def add_direction (direction)
    @direction = direction
    @current_station = direction.route[0]
    direction.route[0].train_on_station[self.number] = self  #добавление поезда на станцию
  end
  #Может перемещаться между станциями, указанными в маршруте. 
  #Перемещение возможно вперед и назад, но только на 1 станцию 
  #за раз. 
  def change_station (change)
    @current_station = @direction.route[+1] if change == "+1"
    # @current_station = @direction.route[@direction.route.index(@current_station).to_i+1] if change == "+1"
    @current_station = @direction.route[@direction.route.index(@current_station).to_i-1] if change == "-1"
  end
  #Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def show_station
    puts "Предыдущая станция: #{@direction.route[@direction.route.index(@current_station).to_i-1]}"
    puts "Текущая станция: #{@current_station}"
    puts "Следующая станция: #{@direction.route[@direction.route.index(@current_station).to_i+1]}"
  end

  def each_vagon (&block)
    @cargo_train.each(&block) 
    @pass_train.each(&block)
  end
end