class QuitCommand < Command
  def run(parts = nil)
    reply = prompt
    has_game = !@system.game.nil?

    if CommandName::YES.include? reply
      @system.game = nil if has_game
      return has_game
    else
      return true
    end

    UnknownCommand.new.run
  end

  private
  def prompt
    prompt_for('Are you sure you want to quit?', [CommandName::YES[0], CommandName::NO[0]], true)
  end
end
