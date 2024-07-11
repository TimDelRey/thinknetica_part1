#cd Desktop/RoR/work/thinknetica_part1/Ruby.Part_7
require_relative 'Station'
require_relative 'Route'
require_relative 'Train'
require_relative 'CargoPass_Type'
require_relative 'CargoPass_vagon'

# ПРИМЕНЧАНИЯ 
# Station.all.values.each do |x|; puts x.title; x.each_train {|x| puts "#{x.number}, #{x.type}, #{x.all_vagons.size}"};end  - перебирает 
# последовательно все станции и для каждой станции выводит список поездов в формате; Номер поезда, тип, кол-во вагонов


# Station.all.values.each do |x|;puts x.title;x.each_train {|x|;puts x.number;x.each_vagon {|x|;puts "#{x.name}, #{x.type}, #{x.free_seats}, #{x.take_seats}" if x.type == "pass";puts "#{x.name}, #{x.type}, #{x.free_volume}, #{x.take_volume}" if x.type == "cargo"}};end
# Перебирает поезда на станции и расписывает у каждого поезда номера вагонов, тип и свободные занятые места и пространства

# неплохо бы квитирующие фразы связать с новыми элементами массивов и хэшей

class Main

  attr_reader :stations, :trains, :routes, :stations_plus, :all_vagons1
  def initialize
    @stations = []
    @stations_plus = {}
    @trains = {}
    @routes = {}
    @i = 0
    @all_vagons1 = {}
    start
    

  end

  def start
    
      loop do
        puts "Выбери действие и впиши номер:"
        puts "1. Создание станции"
        puts "2. Создание поезда"
        puts "3. Создание маршрута и управление станциями"
        puts "4. Назначение маршрута поезду"
        puts "5. Меню вагонов"
        # puts "6. Отцепление вагона от поезда"
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
          otrabotka_runtimeerror {vagon_menu}
        # when 6
        #   otrabotka_runtimeerror {delete_vagon}
        when 7
          otrabotka_runtimeerror {move_train}
        when 8
          otrabotka_runtimeerror {show_list}
        when 0
          break
          return puts "Data saved"
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
    @stations_plus[title] = station1
  end

  def create_train #2
    puts "Укажите номер поезда"
    train_number = gets.chomp.to_s
    puts "Укажите тип поезда (1 - ГРУЗОВОЙ или 2 - ПАССАЖИРСКИЙ)"
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
    proverka_nalichia(@stations_plus.keys, start)
    # rescue RuntimeError
    #   puts "Введите существующую станцию"
    #   retry if @stations.include?(start) == false

    # while @stations.include?(start) == false || start == "close"
    #   puts "Введите существующую станцию"
    #   start = gets.chomp
    # end

    puts "Задана стартовая станция: #{start}, введите конечную станцию"
    finish = gets.chomp
    proverka_nalichia(@stations_plus.keys, finish)
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
      puts "#{key} - #{value.route[0].title} - #{value.route[-1].title}"
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
      puts "#{key} - #{value.route[0].title} - #{value.route[-1].title}"  # в routs теперь сидят обьекты станций, нужно вывести их title
    end

    route1 = gets.chomp.to_i
    proverka_nalichia(@routes, route1) #проверка
    @trains[train_number].add_direction(@routes[route1])
    #показать какой поезд и на какой станции 
    Station.all.values.each do |x|
      puts puts "На станции #{x.title} размещены поезда:"
      x.each_train {|x| puts "номер: #{x.number}, тип: #{x.type}, кол-во вагонов: #{x.all_vagons.size}"}
    end

    puts "Поезд #{train_number} помещен на станцию #{@trains[train_number].current_station.title}"
  end

  def vagon_menu #5
    puts "1 - Добавить вагон, 2 - ОТЦЕПИТЬ ВАГОН, 3 - ЗАНЯТЬ ВАГОН"
    vagon_choice = gets.chomp.to_i
    case vagon_choice
    when 1
      add_type_vagon
    when 2
      delete_vagon
    when 3 
      take_vagon
    else
      puts "Ошибка выбора"
    end
  end

  def add_type_vagon #5.1
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
    if @all_vagons1.include? (number_of_vagon)
      if @all_vagons1[number_of_vagon].type == trains[train_number].type
        #добавить вагон
        @trains[train_number].add_vagon(@all_vagons1[number_of_vagon])
      else
        puts "Вагон уже создан и не соответствует типу поезда"
      end
    else
      if @trains[train_number].type == "cargo"
        puts "Введите общий объем в грузовом вагоне:"
        all_volume = gets.chomp #<= ННАДО БОДАВИТЬ ОБРАБОТЧИК ПО ТИПУ АРГУМЕНТА И ВСТРОЕННЫМ ИСКЛЮЧЕНИЯМ
        vagon1 = CargoVagon.new(number_of_vagon, all_volume) 
      end
      if @trains[train_number].type == "pass"
        puts "Введите кол-во мест в пассажирском вагоне:"
        all_seats = gets.chomp #<= НАДО БОДАВИТЬ ОБРАБОТЧИК ПО ТИПУ АРГУМЕНТА И ВСТРОЕННЫМ ИСКЛЮЧЕНИЯМ
        vagon1 = PassVagon.new(number_of_vagon, all_seats)
      end
      @all_vagons1[number_of_vagon] = vagon1
      @trains[train_number].add_vagon(vagon1)
    end 
    #показать обновленный список вагонов у поезда
    puts "Поезд #{train_number} состоит из вагонов:"
    puts "#{@trains[train_number].each_vagon {|x| puts x.name}}"
  end

  def delete_vagon #5.2
    puts "Выберите поезд для удаления вагона"
    @trains.each do |key, value|
      puts "#{key} - #{value.type}"
    end
    puts "Введите номер поезда"
    train_number = gets.chomp.to_s
    proverka_nalichia(@trains, train_number) #проверка

    puts "Из списка вагонов:"
    if @trains[train_number].type == "cargo"
    @trains[train_number].cargo_train.keys.each do |numbers|
      puts "#{numbers}"
    end
    end
    if @trains[train_number].type == "pass"
    @trains[train_number].pass_train.keys.each do |numbers|
      puts "#{numbers}"
    end
    end
    puts "Введите номер вагона который хотите удалить"
    number_of_vagon = gets.chomp.to_i

    @trains[train_number].delete_vagon(number_of_vagon)

    #показать обновленный список вагонов у поезда
    puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].cargo_train.keys}" if @trains[train_number].type == "cargo"
    puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].pass_train.keys}" if @trains[train_number].type == "pass"
  end

  def take_vagon #5.3
    puts "Выберите вагон из списка:"
    puts "#{@all_vagons1.keys}"
    take_vagon_choice = gets.chomp.to_i

    vagon = @all_vagons1[take_vagon_choice]

    # if @all_vagons1.key?(take_vagon_choice)
   
      if vagon.type == "cargo"
        puts "Выберите занимаемый объем"
        take_vagon_volume = gets.chomp.to_i
        vagon.fill_volume(take_vagon_volume)
        puts "Занят объем вагона #{vagon.take_volume}/#{vagon.all_volume}"
      end
      if vagon.type == "pass"
        vagon.take_place
        puts "Занят объем вагона #{vagon.take_seats}/#{vagon.all_seats}"
      end
    # else 
    #   puts "vagons hash is empty"
    #   puts "#{vagon}"
    #   puts "#{@all_vagons1}"
    # end
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
    puts "У поезда #{train_number} назначен маршрут: #{trains[train_number].direction.route}"
    puts "Введите действие движения поезда по маршруту:"
    puts "1 - на следующую станцию"
    puts "2 - на предыдущую станцию"
    move = gets.chomp.to_i
    @trains[train_number].change_station("+1") if move == 1
    @trains[train_number].change_station("-1") if move == 2


    #показать поезд на текущей станции
    puts "Поезд #{train_number} перемещен на станцию #{@trains[train_number].current_station.title}"
  end

  def show_list #8
    list_of_station = []
    puts "Список станций:"
    puts "#{Station.all.keys}"

    puts "Введите станцию для просмотра поездов:"
    look_station = gets.chomp.to_s
    proverka_nalichia(@stations, look_station) #проверка
    if @trains.empty?
      puts "На станции нет поездов"
      else
        @trains.each do |key, value|
          if look_station == value.current_station.title
            list_of_station << key
          end 
          puts "На станции #{look_station} поезда: #{list_of_station}"

      end
    end
    
  end
end

