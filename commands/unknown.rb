class UnknownCommand < Command
  def run(parts = nil)
    print_result('Unrecognized command. Type \'help\' for help.', true)
    true
  end
end
