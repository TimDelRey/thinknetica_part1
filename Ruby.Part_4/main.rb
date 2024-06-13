#cd Desktop/RoR/work/thinknetica_part1/Ruby.Part_4
require_relative 'lesson4,1_Station'
require_relative 'lesson4,2_Route'
require_relative 'lesson4,3_Train'
require_relative 'CargoPass_Type'
require_relative 'CargoPass_vagon'

class Main
  attr_accessor :stations, :trains, :routes
  def initialize
    @stations = []
    @trains = {}
    @routes = {}
    @i = 0
  end

  def start
    loop do
      puts "Выбери действие и впиши номер:"
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. создать маршрут и управлять станциями"
      puts "4. Назначить маршрут поезду"
      puts "5. Добавить вагоны поезду"
      puts "6. Отцепить вагоны от поезда"
      puts "7. Перемещать поезд по маршруту вперед и назад"
      puts "8. Просматривать список станций и список поездов на станции"
      puts "0. Что бы выйти"
      @choice = gets.chomp.to_i
      case @choice
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        train_add_route
      when 5
        add_vagon
      when 6
        delete_vagon
      when 7
        move_train
      when 8
        show_list
      end
      break if @choice == 0
    end
  end



  def create_station #1
    puts "Выберите название станции:"
    title = gets.chomp
    station1=Station.new(title)
    @stations.push(title)
  end

  def create_train #2
    puts "Укажите номер поезда"
    number = gets.chomp.to_i
    puts "Укажите тип поезда(грузовой или пассажирский)"
    type = gets.chomp.to_s
    train1 = Train.new(number, type)
    @trains[number] = train1
  end

  def create_route #3
    puts "Выберите начальную станцию"
    # проверка start и finish в перечне введенных станций
    start = gets.chomp
    while @stations.include?(start) == false || start == "close"
      puts "Введите существующую станцию"
      start = gets.chomp
    end
    puts "Задана стартовая станция: #{start}, введите конечную станцию"
    finish = gets.chomp
    while @stations.include?(finish) == false || finish == "close"
      puts "Введите существующую станцию"
      finish = gets.chomp
    end
    puts "Задана конечная станция #{finish}"
    puts "Введен маршрут #{start} - #{finish}"
    
    route1=Route.new(start, finish)
    @routes[@i] = route1
    @i += 1
  end

  def train_add_route #4
    puts "Введите номер поезда"
    train1 = gets.chomp
    #----------
    puts "Введите маршрут из списка"
    puts "Список маршрутов:"
    @routes.each do |key, value|
      puts "#{key} - #{value}"
    end
    #------------
    route1 = gets.chomp
    @trains[train1].add_direction(@routes[route1])
  end

  def show_list #8
    puts "Список станций:"
    puts "#{@stations}"
    puts "Список поездов:"
    @trains.each do |key, value| 
      puts "#{key}"
    end
    puts "Список маршрутов:"
    @routes.each do |key, value|
      puts "#{key} - #{value}"
    end
  end








end