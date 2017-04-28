class StartCommand < Command
  def run
    @system.game = Game::Game.new
    print_welcome
    true
  end

  private
  def print_welcome
    lines = [
      '',
      'New game created!',
    ]

    print lines, true
  end
end
