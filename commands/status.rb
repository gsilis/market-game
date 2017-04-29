class StatusCommand < Command
  def run(parts = nil)
    print_inventory
    print_funds

    true
  end

  private
  def print_inventory
    space = @game.space
    level_lines = @game.stash.select { |key, value| value > 0 }
    level_lines = level_lines.map do |key, value|
      format_line [
        { text: key.capitalize, padding: 10 },
        { text: Game::Strings.humanize(value), padding: 50, align: :right }
      ]
    end

    if level_lines.size == 0
      level_lines << format_line([{ text: 'Nothing in inventory', padding: 60 }])
    end

    print_title "Inventory [#{space[0]}/#{space[1]}]", false
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
