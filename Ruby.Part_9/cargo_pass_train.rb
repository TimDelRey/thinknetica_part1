# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def type
    type = 'cargo'
  end
end

class PassTrain < Train
  def type
    type = 'pass'
  end
end
