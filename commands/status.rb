class StatusCommand < Command
  def run(parts = nil)
    print_inventory
    print_funds

    true
  end

  private
  def print_inventory
    level_lines = @game.stash.select { |key, value| value > 0 }
    level_lines = level_lines.map do |key, value|
      format_line [
        { text: key, padding: 20 },
        { text: value, padding: 20, align: :right }
      ]
    end

    return if level_lines.size == 0

    print_table [''] + level_lines
  end

  def print_funds
    funds_lines = {
      Cash: @game.cash,
      Bank: @game.savings,
    }.map do |key, value|
      format_line [
        { text: key.to_s, padding: 20 },
        { text: '$' + value.to_s, padding: 20, align: :right }
      ]
    end

    print_table [''] + funds_lines, true
  end
end
