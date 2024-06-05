#cd Desktop/RoR/work/thinknetica_part1/Ruby.Part_4
require_relative 'lesson4,1_Station'
require_relative 'lesson4,2_Route'
require_relative 'lesson4,3_Train'
require_relative 'CargoPass_Type'
require_relative 'CargoPass_vagon'
#require_relative 'test1'
#require_relative 'test2'
#для теста
  train1=Train.new(111,"cargo")
  train2=Train.new(222,"pass")

  vagon1=CargoVagon.new("vagon1")
  vagon2=PassVagon.new("vagon2")
  vagon3=CargoVagon.new("vagon3")
  vagon4=PassVagon.new("vagon4")

train1.add_vagon(vagon1)
train1.add_vagon(vagon2)
train1.add_vagon(vagon3)
train1.add_vagon(vagon4)

train2.add_vagon(vagon1)
train2.add_vagon(vagon2)
train2.add_vagon(vagon3)
train2.add_vagon(vagon4)