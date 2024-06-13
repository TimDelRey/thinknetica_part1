cd Desktop/RoR/work/thinknetica_part1/Ruby.Part_4


для теста

test1=Main.new
test1.create_station

test.creat_station





case choice  
when 1    create_station  
when 2     create_train
  def create_station  
    puts "Введите имя станции:"
    name_station_choice = gets.chomp.downcase  
    station = Station.new(name_station_choice)  
    stations << stationend
    #может это потребует инициализации состояния, по типу:
    class Main  
      def initialize    
        @trains = []    
        @stations = []     
      end  
      def start     
        loop do
          def create_station  
            puts "Введите имя станции:"  
            name_station_choice = gets.chomp.downcase  
            station = Station.new(name_station_choice)  
            @stations << station
          end
        end
        Main.new.start 
        #разобраться с наследованием - общие методы должны лежать в базовом классе
        class CargoTrain < Train  
          def initialize(number, type = 'грузовой', wagons = [])    
            super  
          end  
          def attach_a_wagon(wagon)    
            @wagons << wagon if @speed == 0 && wagon.is_a?(CargoWagon)  
          end  
          def unhook_the_wagon    
            @wagons.delete_at(-1) if @speed == 0 && @wagons.size > 0  
          end
        end
#вот это неверно.Должно быть
        class CargoTrain < Train  
          def initialize(number, wagons = [])    
            @type = :cargo    
            super  
          end
        end
        А 
        attach_a_wagon - общее поведение - в базовом классе.
        class Train  
          def attach_a_wagon(wagon)      
            @wagons << wagon if @speed == 0 && wagon.type == type  
            end
          end
          +в Wago