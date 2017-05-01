class StoreCommand < Command
  def run(parts = nil)
    in_store = true

    while in_store
      print_menu
      current_funds = Game::Strings.monetize @game.cash
      reply = Readline.readline "store with #{current_funds}> ", true
      parts = reply.split(' ')
      possible_command = parts[0]

      if parts.size < 3
        quantity = 1
        item = parts[1]
      else
        quantity = (parts[1] || '1').to_i
        item = parts[2]
      end

      case possible_command
      when 'quit'
        in_store = false
        print_result 'Leaving store', true
      when 'buy'
        print_result('Enter an item name.', true) if item.nil?
        in_store = buy_item item, quantity unless item.nil?
      else
        UnknownCommand.new(@system, @game).run()
      end
    end

    true
  end

  def print_menu
    store_lines = @game.store_items.all.each_with_index.map do |item, index|
      item_price = @game.store_price_for(item.name)

      format_line [
        { text: item.title, padding: 10 },
        { text: item.description, padding: 20 },
        { text: Game::Strings.monetize(item_price), padding: 30, align: :right }
      ]
    end
    
    store_lines << format_line([
      { text: 'type \'buy\', \'quit\'', padding: 60, align: :right }
    ])

    print_title 'The Store', false, 60
    print_table store_lines, true
  end

  def buy_item(item_name = nil, quantity = 0)
    return false if item_name.nil?

    if @game.store_purchase(item_name, quantity)
      print_result "Bought #{quantity} #{item_name}", true
      true
    else
      print_result "Could not buy #{quantity} #{item_name}", true
      false
    end
  end
end
