class QuitCommand < Command
  def run
    reply = prompt_for('Are you sure you want to quit? yes/no', true)
    !(reply == CommandName::YES)
  end
end
