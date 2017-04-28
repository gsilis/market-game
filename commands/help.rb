class HelpCommand < Command
  def run
    parts = [
      '',
      'buy        [product_name], [quantity]    Buys quantity of product. Omit quantity to buy maximum.',
      'cities                                   Lists the available cities to travel to.',
      'deposit    [amount]                      Deposits money into your bank account.',
      'prices                                   Shows prices of products in your current city.',
      'sell       [product_name], [quantity]    Sell quantity of product. Omit quantity to sell maximum.',
      'status                                   Displays detailed status.',
      'travel     [city_name]                   Travels to another city.',
      'withdraw   [amount]                      Withdraws money from your bank account.',
      '',
      ''
    ]

    puts parts.join("\n")
    true
  end
end
