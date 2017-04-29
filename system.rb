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
      case possible_command
      when CommandName::QUIT
        command = QuitCommand
      when CommandName::STATUS
        command = StatusCommand
      when CommandName::SAVE
        command = SaveCommand
      when CommandName::BUY
        command = BuyCommand
      when CommandName::SELL
        command = SellCommand
      when CommandName::SAVE
        command = SaveCommand
      when CommandName::TRAVEL
        command = TravelCommand
      when CommandName::CITIES
        command = CitiesCommand
      when CommandName::PRICES
        command = PricesCommand
      when CommandName::DEPOSIT
        command = DepositCommand
      when CommandName::WITHDRAW
        command = WithdrawCommand
      when CommandName::WAIT
        command = WaitCommand
      when CommandName::HELP
        command = HelpCommand
      end

      command
    end

    def handle_menu_input(possible_command)
      case possible_command
      when CommandName::QUIT
        command = QuitCommand
      when CommandName::START
        command = StartCommand
      when CommandName::HELP
        command = HelpCommand
      when CommandName::LOAD
        command = LoadCommand
      end

      command
    end
  end
end
