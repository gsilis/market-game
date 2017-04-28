require './command-name'

module Game
  class System
    def initialize
      @game = nil
    end

    def prompt
      'marketplace> '
    end

    def handle_input(possible_command)
      return false if possible_command == CommandName::QUIT
      
      if possible_command == CommandName.start
        
      end

      true
    end
  end
end
