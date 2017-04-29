class TravelCommand < Command
  def run(parts)
    city_name = parts.join('_')

    if city_name && @game.travel(city_name)
      result("You are now in #{@game.city}.")
      PricesCommand.new(@system, @game).run(parts)
    else
      result("Could not travel to '#{city_name}'.")
      CitiesCommand.new(@system, @game).run(parts)
    end

    true
  end
end
