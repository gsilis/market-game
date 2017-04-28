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
      ''
    ]

    spacer = '-' * parts.inject(0) do |max_length, part|
      max_length = part.size if part.size > max_length
      max_length
    end

    puts parts.join("\n#{spacer}\n") + "\n"
    true
  end
end
