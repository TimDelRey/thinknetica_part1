
class Testo
  @@schet = 0
  def self.testo
    @@schet += 1
  end 














  def initialize
    self.class.testo
    puts "Обьект класса создан #{@@schet}"
  end 
end