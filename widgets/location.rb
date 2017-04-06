module Game
  class Location
    attr_accessor :name

    def initialize(initial_location=nil)
      @name = initial_location
    end

    def name=(new_name)
      @name = new_name
    end
  end
end
