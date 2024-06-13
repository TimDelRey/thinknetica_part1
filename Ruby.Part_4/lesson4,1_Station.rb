class Station
  attr_writer :title
#  attr_reader :trains_list
  def initialize (title)
    @title = title
#    @cargo_type = []
#    @pas_type = []
#    @trains_list = []
#    @train = train
  end

#  def add_train (train, type)
#    @trains_list.push (train)
#    if type == "cargo"
#    @cargo_type.push (train)
#    end 
#    if type == "pass"
#    @pas_type.push (train)
#    end
#  end
#  def show_trains_list
#    puts "На станции поезда:"
#    @trains_list.each {|train| puts train}
#  end
#  def show_type
#    puts "Грузовых поездов: #{@cargo_type.size}"
#    puts "Пассажирских поездов: #{@pas_type.size}"
#  end
#  def otpravka(train)
#    @trains_list.delete(train)
#  end
end