require './commands/base'
require './commands/buy'
require './commands/cities'
require './commands/deposit'
require './commands/help'
require './commands/load'
require './commands/name'
require './commands/prices'
require './commands/quit'
require './commands/save'
require './commands/sell'
require './commands/start'
require './commands/status'
require './commands/travel'
require './commands/unknown'
require './commands/withdraw'
require './commands/wait'
require './game'

module Game
  class System
    attr_accessor :game

    def initialize
      @game = nil
    end

    def prompt
      if @game.nil?
        'marketplace > '
      else
        city = @game.city
        cash = @game.cash

        "#{city} with $#{cash} > "
      end
    end

    def handle_input(input)
      parts = input.split(' ')
      possible_command = parts.shift

      if @game.nil?
        command = handle_menu_input(possible_command) || UnknownCommand
      else
        command = handle_game_input(possible_command) || UnknownCommand
      end

      command.new(self, @game).run(parts)
    end

    private
    def handle_game_input(possible_command)
      available = [
        CommandName::BUY,
        CommandName::CITIES,
        CommandName::DEPOSIT,
        CommandName::HELP,
        CommandName::PRICES,
        CommandName::QUIT,
        CommandName::SAVE,
        CommandName::SELL,
        CommandName::STATUS,
        CommandName::TRAVEL,
        CommandName::WAIT,
        CommandName::WITHDRAW,
      ]

      find_command_in available, possible_command
    end

    def handle_menu_input(possible_command)
      available = [
        CommandName::HELP,
        CommandName::LOAD,
        CommandName::QUIT,
        CommandName::START,
      ]

      find_command_in available, possible_command
    end

    def find_command_in(list, possible_command)
      found_command = nil
      base_name = nil

      list.each do |command|
        if command.include? possible_command
          found_command = command[0]
        end
      end

      Object.const_get(found_command.capitalize + 'Command') if found_command
    end
  end
end
