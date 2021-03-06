module Game
  class Products
    def initialize(products)
      @products = products
    end

    def all
      @products
    end

    def find_by_name(name)
      candidates = all.select do |item|
        item.name == name
      end

      candidates[0]
    end

    def include?(value)
      all.map(&:name).include? normalize(value)
    end

    private
    def normalize(name = '')
      case name
      when Symbol
        name = name.to_s
      end
      name
    end
  end

  class Product
    attr_reader :name, :description, :range

    def initialize(name, description, range, effect_item = nil, &block)
      @name = name
      @description = description
      @range = range
      @effect_item = effect_item
      @effect = block
    end

    def title
      Strings::titleize @name
    end

    def re_range(new_min = nil, new_max = nil)
      new_min = new_min || @range.min
      new_max = new_max || @range.max

      return false if new_min >= new_max

      @range = Range.new new_min, new_max
    end

    def apply_effect(times)
      return false if @effect.nil?
      @effect.call @effect_item, times
    end
  end
end
