class CargoTrain < Train
  private
  def type
    type = "cargo"
  end
end

class PassTrain < Train
  private
  def type
    type = "pass"
  end
end
