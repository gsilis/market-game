class StartCommand < Command
  def run(parts = nil)
    @system.game = @game = Game::Game.new
    print_welcome
    true
  end

  private
  def print_welcome
    lines = [
      "You wake up in #{@game.city} with $#{@game.cash} in your pocket.",
      'Type \'help\' for available commands'
    ]

    print_title 'New Game'
    print_lines lines, true
  end
end
