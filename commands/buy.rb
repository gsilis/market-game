class BuyCommand < Command
  def run(parts)
    product_name = nil
    quantity = nil

    if parts.size >= 2
      product_name = parts[1]
      quantity = parts[0].to_i
    else
      product_name = parts[0]
    end

    if product_name && @game.buy(product_name, quantity)
      bought_quantity = @game.count_for product_name

      result "Bought #{bought_quantity} of #{product_name}", true
    else
      result "Could not buy #{product_name}. Is it actually a product?", true
    end

    true
  end
end
