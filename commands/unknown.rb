class UnknownCommand < Command
  def run
    result('Unrecognized command. Type \'help\' for help.', true)
    true
  end
end
