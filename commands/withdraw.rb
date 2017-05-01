class WithdrawCommand < Command
  def run(parts)
    if ['', 'all'].include? parts[0]
      amount = @game.savings
    else
      amount = parts[0].to_i
    end

    if amount && @game.withdraw(amount)
      print_result("Withdrew #{Game::Strings.monetize(amount)} from your account. Your balance is #{Game::Strings.monetize(@game.savings)}.", true)
    else
      print_result("Could not withdraw #{Game::Strings.monetize(amount)}.")
    end

    true
  end
end
