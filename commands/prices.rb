class PricesCommand < Command
  def run(parts = nil)
    city = @game.city
    products = @game.products.all
    price_lines = products.map do |product|
      price = @game.price_for(product.name)

      format_line [
        { text: product.name.capitalize, padding: 30 },
        { text: Game::Strings.monetize(price), padding: 30, align: :right }
      ]
    end

    print_table [''] + price_lines, true

    true
  end
end
