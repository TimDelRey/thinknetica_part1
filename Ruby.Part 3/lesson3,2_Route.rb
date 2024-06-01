class Route
  #Имеет начальную и конечную станцию, а также список 
  #промежуточных станций. Начальная и конечная станции 
  #указываютсся при создании маршрута, а промежуточные могут 
  #добавляться между ними.
  attr_reader :route
  def initialize (start, finish)
    @start = start
    @finish = finish
    @route = []
    @route [0] = start
    @route.push(finish)
  end
  #Может добавлять промежуточную станцию в список
  def add_station (station)
    @route.delete_at(-1)
    @route.push (station)
    @route.push (@finish)
#    @route.insert(-2, station)
  end
  #Может удалять промежуточную станцию из списка
  def del_station (station)
    @route.delete(station)
  end
  #Может выводить список всех станций по-порядку от начальной 
  #до конечной
  def show_route
    puts "Станции на маршруте:"
    @route.each {|station| puts station}
  end
#  def route
#    @route
#  end
end