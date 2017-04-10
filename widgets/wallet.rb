module Game
  class Wallet
    attr_reader :balance

    def initialize(initial_balance = 0)
      @balance = initial_balance
    end

    def debit(amount)
      if amount > 0 && @balance - amount >= 0
        @balance -= amount
        true
      else
        false
      end
    end

    def credit(amount)
      if amount > 0
        @balance += amount
        true
      else
        false
      end
    end
  end
end
