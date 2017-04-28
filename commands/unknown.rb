class UnknownCommand < Command
  def run(parts = nil)
    result('Unrecognized command. Type \'help\' for help.', true)
    true
  end
end
