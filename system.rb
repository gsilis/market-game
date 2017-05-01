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
require './commands/store'
require './commands/travel'
require './commands/unknown'
require './commands/withdraw'
require './commands/wait'
require './game'
require './widgets/commands';
require 'money'

Money.default_formatting_rules = { en: { number: { currency: { symbol: { USD: '$' } } } } }

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
        cash = Strings.monetize(@game.cash)

        "#{city} with #{cash} > "
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
        CommandName::STORE,
        CommandName::TRAVEL,
        CommandName::WAIT,
        CommandName::WITHDRAW,
      ]

      Commands.find_command_in available, possible_command
    end

    def handle_menu_input(possible_command)
      available = [
        CommandName::HELP,
        CommandName::LOAD,
        CommandName::QUIT,
        CommandName::START,
      ]

      Commands.find_command_in available, possible_command
    end
  end
end
