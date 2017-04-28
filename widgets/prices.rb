module Game
  class Prices
    def initialize(products)
      @prices = calculate_prices(products)
    end

    def price_for(name)
      @prices[normalize(name)] || 0
    end

    private
    def normalize(value)
      case value
      when Symbol
        value = value.to_s
      end
      value
    end

    def calculate_prices(products)
      product_prices = {}

      products.each do |product|
        product_prices[product.name] = rand product.range
      end

      product_prices
    end
  end
end
