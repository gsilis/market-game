module Game
  class Products
    def initialize(products = nil)
      @products = products || default_products
    end

    def all
      @products
    end

    def include?(value)
      all.map(&:name).include? value
    end

    private
    def default_products
      [
        Product.new('Lorem', 1..10),
        Product.new('Ipsum', 11..30),
        Product.new('Sumet', 40..75),
        Product.new('Donec', 100..150)
      ]
    end
  end

  private
  class Product
    attr_reader :name, :range

    def initialize(name, range)
      @name = name
      @range = range
    end

    def re_range(new_min = nil, new_max = nil)
      new_min = new_min || @range.min
      new_max = new_max || @range.max

      return false if new_min >= new_max

      @range = Range.new new_min, new_max
    end
  end
end
