module Game
  class Location
    attr_accessor :city

    def initialize(initial_city=nil)
      @city = initial_city
    end

    def name=(new_city)
      @city = new_city
    end
  end
end
