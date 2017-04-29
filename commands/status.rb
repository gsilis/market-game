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
      product_space = ' ' * (20 - key.to_s.size)
      value_space = ' ' * (21 - value.to_s.size)

      "#{key}#{product_space}#{value_space}#{value}"
    end

    return if level_lines.size == 0

    print_title 'Inventory'
    print_lines level_lines, true
  end

  def print_funds
    funds_lines = {
      Cash: @game.cash,
      Bank: @game.savings,
    }.map do |key, value|
      name = key.to_s
      amount = value.to_s

      name_spacing = ' ' * (20 - name.size)
      amount_spacing = ' ' * (20 - amount.size)

      "#{name}#{name_spacing}#{amount_spacing}$#{amount}"
    end

    print_title 'Funds'
    print_lines funds_lines, true
  end
end
