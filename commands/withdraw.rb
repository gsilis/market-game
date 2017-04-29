class WithdrawCommand < Command
  def run(parts)
    if parts[0] == 'all'
      amount = @game.savings
    else
      amount = parts[0].to_i
    end

    if amount && @game.withdraw(amount)
      result("Withdrew #{Game::Strings.monetize(amount)} from your account. Your balance is #{Game::Strings.monetize(@game.savings)}.", true)
    else
      result("Could not withdraw #{Game::Strings.monetize(amount)}.")
    end

    true
  end
end
