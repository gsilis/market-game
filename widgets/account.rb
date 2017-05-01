module Game
  class Account
    attr_reader :balance, :interest

    def initialize(initial_balance = 0, interest = 1.0)
      @balance = initial_balance
      @interest = interest
    end

    def credit(amount)
      @balance += amount
    end

    def debit(amount)
      @balance -= amount
    end

    def accrue_interest
      @balance = (@balance * @interest).ceil.to_i
    end

    def interest=(new_interest)
      @interest = new_interest
    end
  end
end
