require_relative 'modules'

class CargoVagon
  include Creater
  attr_reader :type, :name
  def initialize (name, type = "cargo")
    @name=name
    @type=type
  end
end

class PassVagon
  include Creater
  attr_reader :type, :name
  def initialize (name, type = "pass")
    @name=name
    @type=type
  end
end

