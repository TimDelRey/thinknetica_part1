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
    @all_vagons = {}
  end

  def start
    loop do
      puts "Выбери действие и впиши номер:"
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. Создать маршрут и управлять станциями"
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
        change_route
      when 4
        train_add_route
      when 5
        add_type_vagon
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
    puts "Укажите тип поезда(1 - грузовой или 2 - пассажирский)"
    type = gets.chomp.to_i
    train1 = CargoTrain.new(number) if type == 1
    train1 = PassTrain.new(number) if type == 2
    @trains[number] = train1
  end

  def change_route #3
    puts "1 - СОЗДАТЬ МАРШРУТ, 2 - ИЗМЕНИТЬ МАРШРУТ"
    change = gets.chomp.to_i
    case change
    when 1
      create_route
    when 2
      edit_route
    end
  end

  def create_route #3.1
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

  def edit_route #3.2
    puts "Выберите маршрут"
    @routes.each do |key, value|
      puts "#{key} - #{value.route}"
    end
    edit_route = gets.chomp.to_i

    puts "Выберите действие с маршрутом: 1 - ДОБАВИТЬ СТАНЦИЮ, 2 - УДАЛИТЬ СТАНЦИЮ"
    edit_move = gets.chomp.to_i
    if edit_move == 1
      puts "Введите новую станцию из списка #{@stations}:"
      edit_new = gets.chomp
      # проверка станции в перечне введенных станций
      while @stations.include?(edit_new) == false || edit_new == "close"
        puts "Введите существующую станцию из списка #{@routes[edit_move].route}"
        edit_new = gets.chomp
      end
      @routes[edit_route].add_station(edit_new)
    end
    if edit_move == 2
      puts "Введите станцию для удаления из списка #{@routes[edit_new].route}"
      edit_del = gets.chomp
      # проверка станции в перечне введенных станций
      while @stations.include?(edit_del) == false || edit_del == "close"
        puts "Введите существующую станцию из списка #{@routes[edit_new].route}"
        edit_del = gets.chomp
      end
      @routes[edit_route].del_station(edit_del)
    end

  end

  def train_add_route #4
    puts "Выберите поезд"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    train1 = gets.chomp.to_i

    puts "Введите маршрут из списка"
    puts "Список маршрутов:"
    @routes.each do |key, value|
      puts "#{key} - #{value.route}"
    end

    route1 = gets.chomp.to_i
    @trains[train1].add_direction(@routes[route1])
    #показать какой поезд и на какой станции 
    puts "Поезд #{train1} помещен на станцию #{@trains[train1].current_station}"
  end

  def add_type_vagon #5
    #определить какомму поезду добавить вагон
    #показать список вагонов у поезда
    puts "Выберите поезд"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    number_of_train = gets.chomp.to_i
    #добавить новый вагон
    puts "Теперь введите номер нового вагона"
    number_of_vagon = gets.chomp.to_i
    #проверка вагона в списке
    if @all_vagons.include? (number_of_vagon)
      if @all_vagons[number_of_vagon].type == trains[number_of_train].type
        #добавить вагон
        @trains[number_of_train].add_vagon(@all_vagons[number_of_vagon])
      else
        puts "Вагон уже создан и не соответствует типу поезда"
      end
    else
      vagon1 = CargoVagon.new(number_of_vagon) if @trains[number_of_train].type == "cargo"
      vagon1 = PassVagon.new(number_of_vagon) if @trains[number_of_train].type == "pass"
      @all_vagons[number_of_vagon] = vagon1
      @trains[number_of_train].add_vagon(vagon1)
    end 
    #показать обновленный список вагонов у поезда
    puts "Поезд #{number_of_train} состоит из вагонов #{@trains[number_of_train].cargo_train}" if @trains[number_of_train].type == "cargo"
    puts "Поезд #{number_of_train} состоит из вагонов #{@trains[number_of_train].pass_train}" if @trains[number_of_train].type == "pass"
  end

  def delete_vagon #6
    puts "Выберите поезд для удаления вагона"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    number_of_train = gets.chomp.to_i

    puts "Выберите вагон"
    if @trains[number_of_train].type == "cargo"
    @trains[number_of_train].cargo_train.each do |numbers|
      puts "#{numbers}"
    end
    end
    if @trains[number_of_train].type == "pass"
    @trains[number_of_train].pass_train.each do |numbers|
      puts "#{numbers}"
    end
    end
    puts "Введите номер вагона который хотите удалить"
    number_of_vagon = gets.chomp.to_i

    @trains[number_of_train].delete_vagon(number_of_vagon)

    #показать обновленный список вагонов у поезда
    puts "Поезд #{number_of_train} состоит из вагонов #{@trains[number_of_train].cargo_train}" if @trains[number_of_train].type == "cargo"
    puts "Поезд #{number_of_train} состоит из вагонов #{@trains[number_of_train].pass_train}" if @trains[number_of_train].type == "pass"
  end

  def move_train #7
    #выбрать поезд
    puts "Выберите поезд для изменений станции"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    number_of_train = gets.chomp.to_i
    #выбрать действие
    puts "У поезда #{number_of_train} назначен маршрут: ЕЩЕ В РАЗРАБОТКЕ"
    puts "Введите действие движения поезда по маршруту:"
    puts "1 - на следующую станцию"
    puts "2 - на предыдущую станцию"
    move = gets.chomp.to_i
    @trains[number_of_train].change_station("+1") if move == 1
    @trains[number_of_train].change_station("-1") if move == 2


    #показать поезд на текущей станции
    puts "Поезд #{number_of_train} перемещен на станцию #{@trains[number_of_train].current_station}"
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
      puts "#{key} - #{value.route}"
    end
  end








end