class WithdrawCommand < Command
  def run(parts)
    amount = parts[0].to_i

    if amount && @game.withdraw(amount)
      result("Withdrew $#{amount} from your account. Your balance is $#{@game.savings}.", true)
    else
      result("Could not withdraw $#{amount}.")
    end

    true
  end
end
