class QuitCommand < Command
  def run
    reply = prompt

    case reply
    when CommandName::YES
      return false
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
