class CargoVagon
  attr_reader :type, :name
  def initialize (name, type = "cargo")
    @name=name
    @type=type
  end
end

class PassVagon
  attr_reader :type, :name
  def initialize (name, type = "pass")
    @name=name
    @type=type
  end
end

