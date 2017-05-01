module Game
  class Inventory
    attr_reader :space

    def initialize(inventory = nil, space = nil)
      @products = inventory || {}
      @space = space || -1
    end

    def update_for(name, amount)
      current_amount = @products[name] || 0

      if current_amount + amount >= 0 && item_count + amount <= @space
        @products[name] = current_amount + amount
        true
      else
        false
      end
    end

    def count_for(name)
      @products[name] || 0
    end
    
    def available_space
      @space - item_count
    end

    def has_space_for(quantity)
      item_count + quantity <= @space
    end

    def levels
      @products
    end

    def space=(new_amount)
      @space = new_amount
    end

    def item_count
      total = 0

      @products.each do |key, value|
        total += value
      end

      total
    end
  end
end
