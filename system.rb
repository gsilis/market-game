require './commands/base'
require './commands/help'
require './commands/name'
require './commands/quit'
require './commands/start'
require './commands/unknown';

module Game
  class System
    def initialize
      @game = nil
    end

    def prompt
      'marketplace> '
    end

    def handle_input(possible_command)
      result = true
      command = UnknownCommand

      case possible_command
      when CommandName::QUIT
        command = QuitCommand
      when CommandName::START
        command = StartCommand
      when CommandName::HELP
        command = HelpCommand
      end

      result = command.new(self, @game).run
      result
    end
  end
end
