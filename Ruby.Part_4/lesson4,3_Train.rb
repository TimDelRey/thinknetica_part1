class Train
  attr_reader :number, :vagon, :cargo_train, :pass_train, :all_vagons
  attr_accessor :speed, :type, :current_station
  attr_writer :number, :vagon
  def initialize (number, speed = 0, current_station = "не назначен")
    @speed = speed
    @number = number
    @type = type
    @cargo_train = []
    @pass_train = []
    @current_station = current_station
  end
  def add_vagon (vagon)
    if self.type == "cargo" && vagon.type == self.type
      @cargo_train.push (vagon.name)      
    end
    if self.type == "pass" && vagon.type == self.type
      @pass_train.push (vagon.name)
    end 
  end

  def delete_vagon (vagon)
    @cargo_train.delete (vagon) 
    @pass_train.delete (vagon)
  end 


  #Может набирать скорость
#  def razgon (speed)
#    @speed = speed
#  end
  #Может возвращать текущую скорость
#  def show_speed
#    puts @speed
#  end
  #Может тормозить (сбрасывать скорость до нуля)
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
  end
  #Может перемещаться между станциями, указанными в маршруте. 
  #Перемещение возможно вперед и назад, но только на 1 станцию 
  #за раз. 
  def change_station (change)
    @current_station = @direction.route[@direction.route.index(@current_station).to_i+1] if change == "+1"
    @current_station = @direction.route[@direction.route.index(@current_station).to_i-1] if change == "-1"
  end
  #Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def show_station
    puts "Предыдущая станция: #{@direction.route[@direction.route.index(@current_station).to_i-1]}"
    puts "Текущая станция: #{@current_station}"
    puts "Следующая станция: #{@direction.route[@direction.route.index(@current_station).to_i+1]}"
  end
end