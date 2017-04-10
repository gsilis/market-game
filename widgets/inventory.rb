module Game
  class Inventory
    def initialize
      @products = {}
    end

    def update_for(name, amount)
      current_amount = @products[name] || 0

      if current_amount + amount >= 0
        @products[name] = current_amount + amount
        true
      else
        false
      end
    end

    def count_for(name)
      @products[name] || 0
    end

    def levels
      @products
    end
  end
end
