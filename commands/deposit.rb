class DepositCommand < Command
  def run(parts)
    if parts[0] == 'all'
      amount = @game.cash
    else
      amount = parts[0].to_i
    end

    if amount && @game.deposit(amount)
      new_balance = @game.savings.to_s
      result("Deposited #{Game::Strings.monetize(amount)} into your account for a new balance of #{Game::Strings.monetize(new_balance)}.", true)
    else
      result("Could not deposit #{Game::Strings.monetize(amount)}.", true)
    end

    true
  end
end
