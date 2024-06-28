module Mesto

    @schet = 0

    def testo

      @schet += 1
      puts "Обьект класса создан #{@schet}"
      @schet
  end  
end






class Testo
  extend Mesto

  def initialize 
    self.class.testo
  end
end 
