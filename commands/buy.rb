class BuyCommand < Command
  def run(parts)
    product_name = parts[0]
    quantity = parts[1] || nil

    if @game.buy product_name, quantity
      bought_quantity = @game.count_for product_name

      result "Bought #{bought_quantity} of #{product_name}", true
    else
      result 'Could not buy #{product_name}. Is it actually a product?', false
    end

    true
  end
end
