class DepositCommand < Command
  def run(parts)
    amount = parts[0].to_i

    if amount && @game.deposit(amount)
      new_balance = @game.savings.to_s
      result("Deposited $#{amount} into your account for a new balance of $#{new_balance}.", true)
    else
      result("Could not deposit $#{amount}.", true)
    end

    true
  end
end
