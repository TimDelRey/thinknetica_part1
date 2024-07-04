#cd Desktop/RoR/work/thinknetica_part1/Ruby.Part_6
require_relative 'lesson4,1_Station'
require_relative 'lesson4,2_Route'
require_relative 'lesson4,3_Train'
require_relative 'CargoPass_Type'
require_relative 'CargoPass_vagon'


class Main

  attr_reader :stations, :trains, :routes
  def initialize
    @stations = []
    @trains = {}
    @routes = {}
    @i = 0
    @all_vagons = {}
    start
    

  end

  def start
    
      loop do
        puts "Выбери действие и впиши номер:"
        puts "1. Создание станции"
        puts "2. Создание поезда"
        puts "3. Создание маршрута и управление станциями"
        puts "4. Назначение маршрута поезду"
        puts "5. Добавление вагона поезду"
        puts "6. Отцепление вагона от поезда"
        puts "7. Перемещение поезда по маршруту вперед и назад"
        puts "8. Список станций и список поездов на станции"
        puts "0. Выход"
        choice = gets.chomp.to_i
        case choice
        when 1
          begin
            create_station
          rescue RuntimeError
            puts "Введите название с заглавной буквы, минимум из 2 букв"
            retry
          end
        when 2
          otrabotka_runtimeerror {create_train}
        when 3
          otrabotka_runtimeerror {change_route}
        when 4
          otrabotka_runtimeerror {train_add_route}
        when 5
          otrabotka_runtimeerror {add_type_vagon}
        when 6
          otrabotka_runtimeerror {delete_vagon}
        when 7
          otrabotka_runtimeerror {move_train}
        when 8
          otrabotka_runtimeerror {show_list}
        when 0
          break
        else
          raise "Неверный формат выбора"
        end
      end
  end

  def otrabotka_runtimeerror(&metod)
    begin
      metod.call
    rescue RuntimeError
      puts "Ошибка ввода"
      retry
    end
  end




  def proverka_nalichia (spisok, peremennaya)
    raise "Отсутствует в перечне" unless spisok.include?(peremennaya)
  end

  def create_station #1
    puts "Выберите название станции:"
    title = gets.chomp
    station1=Station.new(title)
    @stations.push(title)
  end

  def create_train #2
    puts "Укажите номер поезда"
    train_number = gets.chomp.to_s
    puts "Укажите тип поезда(1 - грузовой или 2 - пассажирский)"
    type = gets.chomp.to_i
    train1 = CargoTrain.new(train_number) if type == 1
    train1 = PassTrain.new(train_number) if type == 2
    @trains[train_number] = train1
  end

  def change_route #3
    puts "1 - СОЗДАТЬ МАРШРУТ, 2 - ИЗМЕНИТЬ МАРШРУТ"
    change = gets.chomp.to_i
    case change
    when 1
      create_route
    when 2
      edit_route
    else
      raise "Неверный формат выбора"
    end
  end

  def create_route #3.1
    puts "Выберите начальную станцию"
    #  проверка start и finish в перечне введенных станций
    start = gets.chomp
    proverka_nalichia(@stations, start)
    # rescue RuntimeError
    #   puts "Введите существующую станцию"
    #   retry if @stations.include?(start) == false

    # while @stations.include?(start) == false || start == "close"
    #   puts "Введите существующую станцию"
    #   start = gets.chomp
    # end

    puts "Задана стартовая станция: #{start}, введите конечную станцию"
    finish = gets.chomp
    proverka_nalichia(@stations, finish)
    # rescue RuntimeError
    #   puts "Введите существующую станцию"
    #   retry if @stations.include?(start) == false

    # while @stations.include?(finish) == false || finish == "close"
    #   puts "Введите существующую станцию"
    #   finish = gets.chomp
    # end
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
    case edit_move
    when 1
      puts "Введите новую станцию из списка #{@stations}:"
      edit_new = gets.chomp
      proverka_nalichia(@stations, edit_new)      # проверка станции в перечне введенных станций
      @routes[edit_route].add_station(edit_new)
    when 2
      puts "Введите станцию для удаления из списка #{@routes[edit_route].route}"
      edit_del = gets.chomp
      proverka_nalichia(@stations, edit_del)      # проверка станции в перечне введенных станций
      @routes[edit_route].del_station(edit_del)
    else
      raise "Неверный формат выбора"
    end
  end

  def train_add_route #4
    puts "Выберите поезд"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда" 
    train_number = gets.chomp.to_s
    proverka_nalichia(@trains, train_number)    #проверка

    puts "Введите маршрут из списка"
    puts "Список маршрутов:"
    @routes.each do |key, value|
      puts "#{key} - #{value.route}"
    end

    route1 = gets.chomp.to_i
    proverka_nalichia(@routes, route1) #проверка
    @trains[train_number].add_direction(@routes[route1])
    #показать какой поезд и на какой станции 
    puts "Поезд #{train_number} помещен на станцию #{@trains[train_number].current_station}"
  end

  def add_type_vagon #5
    #определить какомму поезду добавить вагон
    #показать список вагонов у поезда
    puts "Из списка поездов:"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    train_number = gets.chomp.to_s
    proverka_nalichia(@trains, train_number) #проверка
    #добавить новый вагон
    puts "Теперь введите номер нового вагона"
    number_of_vagon = gets.chomp.to_i
    #проверка вагона в списке
    if @all_vagons.include? (number_of_vagon)
      if @all_vagons[number_of_vagon].type == trains[train_number].type
        #добавить вагон
        @trains[train_number].add_vagon(@all_vagons[number_of_vagon])
      else
        puts "Вагон уже создан и не соответствует типу поезда"
      end
    else
      vagon1 = CargoVagon.new(number_of_vagon) if @trains[train_number].type == "cargo"
      vagon1 = PassVagon.new(number_of_vagon) if @trains[train_number].type == "pass"
      @all_vagons[number_of_vagon] = vagon1
      @trains[train_number].add_vagon(vagon1)
    end 
    #показать обновленный список вагонов у поезда
    puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].cargo_train}" if @trains[train_number].type == "cargo"
    puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].pass_train}" if @trains[train_number].type == "pass"
  end

  def delete_vagon #6
    puts "Выберите поезд для удаления вагона"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    train_number = gets.chomp.to_s
    proverka_nalichia(@trains, train_number) #проверка

    puts "Из списка вагонов:"
    if @trains[train_number].type == "cargo"
    @trains[train_number].cargo_train.each do |numbers|
      puts "#{numbers}"
    end
    end
    if @trains[train_number].type == "pass"
    @trains[train_number].pass_train.each do |numbers|
      puts "#{numbers}"
    end
    end
    puts "Введите номер вагона который хотите удалить"
    number_of_vagon = gets.chomp.to_i

    @trains[train_number].delete_vagon(number_of_vagon)

    #показать обновленный список вагонов у поезда
    puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].cargo_train}" if @trains[train_number].type == "cargo"
    puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].pass_train}" if @trains[train_number].type == "pass"
  end

  def move_train #7
    #выбрать поезд
    puts "Выберите поезд для изменений станции"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    train_number = gets.chomp.to_s
    proverka_nalichia(@trains, train_number) #проверка
    #выбрать действие
    puts "У поезда #{train_number} назначен маршрут: ЕЩЕ В РАЗРАБОТКЕ"
    puts "Введите действие движения поезда по маршруту:"
    puts "1 - на следующую станцию"
    puts "2 - на предыдущую станцию"
    move = gets.chomp.to_i
    @trains[train_number].change_station("+1") if move == 1
    @trains[train_number].change_station("-1") if move == 2


    #показать поезд на текущей станции
    puts "Поезд #{train_number} перемещен на станцию #{@trains[train_number].current_station}"
  end

  def show_list #8
    list_of_station = []
    puts "Список станций:"
    puts "#{@stations}"

    puts "Введите станцию для просмотра поездов:"
    look_station = gets.chomp.to_s
    proverka_nalichia(@stations, look_station) #проверка
    if @trains.empty?
      puts "На станции нет поездов"
      else
        @trains.each do |key, value|
          if look_station == value.current_station
            list_of_station << key
          end 
          puts "На станции #{look_station} поезда: #{list_of_station}"

      end
    end
    
  end
end

