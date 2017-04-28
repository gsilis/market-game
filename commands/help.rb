class HelpCommand < Command
  def run(parts = nil)
    if @game.nil?
      parts = main_menu
    else
      parts = game_menu
    end

    print_title 'Available Commands'
    print_table parts, true
    true
  end

  private
  def main_menu
    [
      'NAME       ARGUMENTS                     DESCRIPTION',
      'load                                     Lists all available game files',
      'load       [game_file_name]              Loads the specified game file',
      'start                                    Starts a new game',
      'quit                                     Quits the program',
    ]
  end

  def game_menu
    [
      'NAME       ARGUMENTS                     DESCRIPTION',
      'buy        [product_name], [quantity]    Buys quantity of product. Omit quantity to buy maximum.',
      'cities                                   Lists the available cities to travel to.',
      'deposit    [amount]                      Deposits money into your bank account.',
      'prices                                   Shows prices of products in your current city.',
      'sell       [product_name], [quantity]    Sell quantity of product. Omit quantity to sell maximum.',
      'status                                   Displays detailed status.',
      'travel     [city_name]                   Travels to another city.',
      'withdraw   [amount]                      Withdraws money from your bank account.',
      'quit                                     Quits the current game'
    ]
  end
end
