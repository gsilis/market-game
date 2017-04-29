class PricesCommand < Command
  def run(parts = nil)
    city = @game.city
    products = @game.products.all
    price_lines = products.map do |product|
      price = @game.price_for(product.name)
      title_spacing = ' ' * (40 - product.name.size)
      price_spacing = ' ' * (5 - price.to_s.size)

      "#{product.name}#{title_spacing}#{price_spacing}$#{price}"
    end

    print_title "Product prices in #{city}"
    print_table price_lines, true

    true
  end
end
