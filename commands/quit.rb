class QuitCommand < Command
  def run(parts = nil)
    reply = prompt
    has_game = !@system.game.nil?

    case reply
    when CommandName::YES
      @system.game = nil if has_game
      return has_game
    when CommandName::NO
      return true
    end

    UnknownCommand.new.run
  end

  private
  def prompt
    prompt_for('Are you sure you want to quit?', [CommandName::YES, CommandName::NO], true)
  end
end
