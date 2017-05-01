class StatusCommand < Command
  def run(parts = nil)
    inventory_space = @game.space

    print_title "Inventory [#{inventory_space[0]}/#{inventory_space[1]}]", false
    print_inventory @game.stash

    print_funds

    print_title "Bought Items", false
    print_inventory @game.bought_items
    print_lines ['']

    true
  end

  private
  def print_inventory(inventory)
    level_lines = inventory.select { |key, value| value > 0 }
    level_lines = level_lines.map do |key, value|
      format_line [
        { text: key.capitalize, padding: 10 },
        { text: Game::Strings.humanize(value), padding: 50, align: :right }
      ]
    end

    if level_lines.size == 0
      level_lines << format_line([{ text: 'Nothing here', padding: 60 }])
    end

    print_table level_lines
  end

  def print_funds
    funds_lines = {
      Cash: @game.cash,
      Bank: @game.savings,
    }.map do |key, value|
      format_line [
        { text: key.to_s.capitalize, padding: 10 },
        { text: Game::Strings.monetize(value), padding: 50, align: :right }
      ]
    end

    print_title 'Funds', false
    print_table funds_lines, true
  end
end
