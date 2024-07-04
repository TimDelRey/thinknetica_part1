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
      rescue
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
# module Creater
#   attr_accessor :creater
# end

# module InstanceCounter
#   def self.included(base)

#     base.extend ClassMethods
#     base.include InstanceMethods
#   end
# end

# module ClassMethods
#   attr_accessor :instances
# end

# module InstanceMethods

#   def schet_instances
#     self.class.instances ||= 0
#     self.class.instances += 1
#     # puts "всего #{@@instances} шт."
#   end
# end

 
