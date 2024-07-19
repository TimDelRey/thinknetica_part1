# cd Desktop/RoR/work/thinknetica_part1/Ruby.Part_8

# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_pass_train'
require_relative 'cargo_pass_vagon'
require_relative 'modules'

# ПРИМЕНЧАНИЯ
# Station.all.values.each do |x|; puts x.title; x.each_train {|x| puts "#{x.number}, #{x.type}, #{x.all_vagons.size}"};end
# перебирает последовательно все станции и для каждой станции выводит список поездов в формате; Номер поезда, тип, кол-во вагонов
# Station.all.values.each do |x|;puts x.title;x.each_train {|x|;puts x.number;x.each_vagon {|x|;puts "#{x.name}, #{x.type}, #{x.free_seats}, #{x.take_seats}" if x.type == "pass";puts "#{x.name}, #{x.type}, #{x.free_volume}, #{x.take_volume}" if x.type == "cargo"}};end
# По станцииям расписывает у каждого поезда номера вагонов, тип и пространства

# надо квитирующие фразы связать с новыми элементами массивов и хэшей

class Main
  include Helper

  attr_reader :trains, :routes, :stations_plus, :all_vagons1

  def initialize
    @stations_plus = {}
    @trains = {}
    @routes = {}
    @i = 0
    @all_vagons1 = {}
    start
  end

  def start
    loop do
      display_menu
      choice = gets.chomp.to_i
      menu = { 1 => :create_station,
               2 => :create_train,
               3 => :change_route,
               4 => :train_add_route,
               5 => :vagon_menu,
               # :6 =>
               7 => :move_train,
               8 => :show_list }
      otrabotka_runtimeerror { send(menu[choice]) } if menu.key?(choice)
      break if choice.zero?
    end
  end

  def otrabotka_runtimeerror
    yield
  rescue RuntimeError
    puts 'Ошибка ввода'
    retry
  end

  def availability_check(list, value)
    raise 'Отсутствует в перечне' unless list.include?(value)
  end

  def create_station
    puts 'Выберите название станции:'
    title = gets.chomp
    station1 = Station.new(title)
    @stations_plus[title] = station1
  end

  def create_train
    puts 'Укажите номер поезда'
    train_number = gets.chomp.to_s
    puts 'Укажите тип поезда (1 - ГРУЗОВОЙ или 2 - ПАССАЖИРСКИЙ)'
    type = gets.chomp.to_i
    train1 = CargoTrain.new(train_number) if type == 1
    train1 = PassTrain.new(train_number) if type == 2
    @trains[train_number] = train1
  end

  def change_route
    puts '1 - СОЗДАТЬ МАРШРУТ, 2 - ИЗМЕНИТЬ МАРШРУТ'
    case gets.chomp.to_i
    when 1
      create_route
    when 2
      edit_route
    else
      raise 'Неверный формат выбора'
    end
  end

  def create_route
    puts 'Выберите начальную станцию'
    start = gets.chomp
    availability_check(@stations_plus.keys, start) # проверка start в перечне введенных станций

    puts "Задана стартовая станция: #{start}, введите конечную станцию"
    finish = gets.chomp
    availability_check(@stations_plus.keys, finish) # проверка finish в перечне введенных станций
    puts "Задана конечная станция #{finish}"
    puts "Введен маршрут #{start} - #{finish}"

    route1 = Route.new(start, finish)
    @routes[@i] = route1
    @i += 1
  end

  def edit_route
    puts 'Выберите маршрут'
    @routes.each { |key, value| puts "#{key} - #{value.route[0].title} - #{value.route[-1].title}" }
    edit_route = gets.chomp.to_i

    puts 'Выберите действие с маршрутом: 1 - ДОБАВИТЬ СТАНЦИЮ, 2 - УДАЛИТЬ СТАНЦИЮ'
    case gets.chomp.to_i
    when 1
      puts "Введите новую станцию из списка #{@stations_plus.keys}:"
      edit_new = gets.chomp
      availability_check(@stations_plus.keys, edit_new) #  проверка станции в перечне введенных станций
      @routes[edit_route].add_station(edit_new)
    when 2
      puts "Введите станцию для удаления из списка #{@routes[edit_route].route}"
      edit_del = gets.chomp
      availability_check(@stations_plus.keys, edit_del) #  проверка станции в перечне введенных станций
      @routes[edit_route].del_station(edit_del)
    else
      raise 'Неверный формат выбора'
    end
  end

  def train_add_route
    puts 'Выберите поезд'
    @trains.each { |key, value| puts "#{key} - #{value.type}" }
    puts 'Введите номер поезда'
    train_number = gets.chomp.to_s
    availability_check(@trains, train_number) # проверка

    puts 'Выберите маршрут из списка маршрутов'
    @routes.each { |key, value| puts "#{key} - #{value.route[0].title} - #{value.route[-1].title}" }

    route1 = gets.chomp.to_i
    availability_check(@routes, route1) # проверка
    @trains[train_number].add_direction(@routes[route1])

    Station.all.each_value do |x|
      puts "На станции #{x.title} размещены поезда:"
      x.each_train { |x| puts "Поезд номер: #{x.number}, тип: #{x.type}, кол-во вагонов: #{x.all_vagons.size}" }
    end
    puts "Поезд #{train_number} помещен на станцию #{@trains[train_number].current_station.title}"
  end

  def vagon_menu
    puts '1 - ДОБАВИТЬ ВАГОН, 2 - ОТЦЕПИТЬ ВАГОН, 3 - ЗАНЯТЬ ВАГОН'
    case gets.chomp.to_i
    when 1
      add_type_vagon
    when 2
      delete_vagon
    when 3
      take_vagon
    else
      puts 'Ошибка выбора'
    end
  end

  def add_type_vagon
    puts 'Из списка поездов:'
    @trains.each { |key, value| puts "#{key} - #{value.type}" }
    puts 'Введите номер поезда'
    train_number = gets.chomp.to_s
    availability_check(@trains, train_number) # проверка

    puts 'Теперь введите номер нового вагона' # добавить новый вагон
    number_of_vagon = gets.chomp.to_i

    if @all_vagons1.include?(number_of_vagon) && @all_vagons1[number_of_vagon].type == @trains[train_number].type
      @trains[train_number].add_vagon(@all_vagons1[number_of_vagon])
    else
      vagon1 = case @trains[train_number].type
               when 'cargo'
                 puts 'Введите общий объем в грузовом вагоне:'
                 CargoVagon.new(number_of_vagon, gets.chomp.to_i)
               when 'pass'
                 puts 'Введите кол-во мест в пассажирском вагоне:'
                 PassVagon.new(number_of_vagon, gets.chomp.to_i)
               end

      if vagon1
        @all_vagons1[number_of_vagon] = vagon1
        @trains[train_number].add_vagon(vagon1)
      end
    end

    puts "Поезд #{train_number} состоит из вагонов:"
    @trains[train_number].each_vagon { |x| puts x.name }
  end

  def delete_vagon
    puts 'Выберите поезд для удаления вагона'
    @trains.each { |key, value| puts "#{key} - #{value.type}" }
    puts 'Введите номер поезда'
    train_number = gets.chomp.to_s
    availability_check(@trains, train_number) # проверка

    puts 'Из списка вагонов:'
    @trains[train_number].cargo_train.each_key { |numbers| puts "#{numbers}" } if @trains[train_number].type == 'cargo'
    @trains[train_number].pass_train.each_key { |numbers| puts "#{numbers}" } if @trains[train_number].type == 'pass'
    puts 'Введите номер вагона который хотите удалить'
    number_of_vagon = gets.chomp.to_i
    @trains[train_number].delete_vagon(number_of_vagon)

    # показать обновленный список вагонов у поезда
    if @trains[train_number].type == 'cargo'
      puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].cargo_train.keys}"
    end
    return unless @trains[train_number].type == 'pass'

    puts "Поезд #{train_number} состоит из вагонов #{@trains[train_number].pass_train.keys}"
  end

  def take_vagon
    puts "Выберите вагон из списка: #{@all_vagons1.keys}"
    take_vagon_choice = gets.chomp.to_i
    vagon = @all_vagons1[take_vagon_choice]
    return puts 'Введеный вагон не существует' unless @all_vagons1.key?(take_vagon_choice)

    if vagon.type == 'cargo'
      puts 'Выберите занимаемый объем'
      take_vagon_volume = gets.chomp.to_i
      vagon.fill_volume(take_vagon_volume)
      puts "Занят объем вагона #{vagon.take_volume}/#{vagon.all_volume}"
    end
    return unless vagon.type == 'pass'

    vagon.take_place
    puts "Занят объем вагона #{vagon.take_seats}/#{vagon.all_seats}"
  end

  def move_train
    puts 'Выберите поезд для изменений станции'
    @trains.each { |key, value| puts "#{key} - #{value.type}" }
    puts 'Введите номер поезда'
    train_number = gets.chomp.to_s
    availability_check(@trains, train_number) # проверка

    puts "У поезда #{train_number} назначен маршрут: #{trains[train_number].direction.route.map { |x| x.title }}"
    puts 'Введите действие движения поезда по маршруту:'
    puts '1 - НА СЛЕДУЮЩУЮ СТАНЦИЮ, 2 - НА ПРЕДЫДУЩУЮ СТАНЦИЮ'
    move = gets.chomp.to_i
    case move
    when 1
      @trains[train_number].station_forward
    when 2
      @trains[train_number].station_back
    else
      raise 'Ошибка ввода'
    end
    puts "Поезд #{train_number} перемещен на станцию #{@trains[train_number].current_station.title}" # показать поезд на текущей станции
  end

  def show_list
    list_of_station = []
    puts "Список станций: #{Station.all.keys}"

    puts 'Введите станцию для просмотра поездов:'
    look_station = gets.chomp.to_s
    availability_check(@stations_plus, look_station) # проверка
    if @trains.empty?
      puts 'На станции нет поездов'
    else
      @trains.each do |key, value|
        list_of_station << key if look_station == value.current_station.title
        puts "На станции #{look_station} поезда: #{list_of_station}"
      end
    end
  end
end
