class WaitCommand < Command
  def run(parts = nil)
    @game.reprice
    result("Waiting in #{@game.city}", true)
    PricesCommand.new(@system, @game).run(parts)
  end
end
