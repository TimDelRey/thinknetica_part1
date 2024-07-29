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

module Accessors

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_var_name = "@#{name}_history".to_sym

      define_method(name) do
        instance_variable_get(var_name)
      end

      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        history = instance_variable_get(history_var_name) || []
        history << value
        instance_variable_set(history_var_name, history)
      end

      define_method("#{name}_history") do
        instance_variable_get(history_var_name) || []
      end
    end
  end

  def strong_arrt_accessor(name, name_class)
    strong_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(strong_name) }

    define_method("#{name}=") do |value|
      raise 'ERROR' unless value.class == name_class
        instance_variable_set(strong_name, value)
    end
  end
end

