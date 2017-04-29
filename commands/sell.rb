class SellCommand < Command
  def run(parts = nil)
    product_name = nil
    quantity = nil

    if parts.size >= 2
      product_name = parts[1]
      quantity = parts[0].to_i
    else
      product_name = parts[0]
    end

    starting_quantity = @game.count_for(product_name)

    if product_name && @game.sell(product_name, quantity)
      ending_quantity = @game.count_for(product_name)
      difference = starting_quantity - ending_quantity
      print_result("Sold #{Game::Strings.humanize(difference)} of #{product_name}.", true)
    else
      print_result("Could not sell #{product_name}. Is it really a product?", true);
    end

    true
  end
end
