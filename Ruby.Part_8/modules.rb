# frozen_string_literal: true

module Creater
  attr_accessor :creater
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
      @instances += 1
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances
    end
  end
end

module Helper
  def display_menu
    puts 'Выбери действие и впиши номер:'
    puts '1. Создание станции'
    puts '2. Создание поезда'
    puts '3. Создание маршрута и управление станциями'
    puts '4. Назначение маршрута поезду'
    puts '5. Меню вагонов'
    # puts '6. Отцепление вагона от поезда''
    puts '7. Перемещение поезда по маршруту вперед и назад'
    puts '8. Список станций и список поездов на станции'
    puts '0. Выход'
  end
end
