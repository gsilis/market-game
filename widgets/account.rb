module Game
  class Account
    attr_reader :balance

    def initialize(initial_balance = 0)
      @balance = initial_balance
    end

    def credit(amount)
      @balance += amount
    end

    def debit(amount)
      @balance -= amount
    end
  end
end
