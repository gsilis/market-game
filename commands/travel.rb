class TravelCommand < Command
  def run(parts)
    city_name = parts.join('_')

    if city_name && @game.travel(city_name)
      print_result("You are now in #{@game.city}.")
      PricesCommand.new(@system, @game).run(parts)
    else
      print_result("Could not travel to '#{city_name}'.")
      CitiesCommand.new(@system, @game).run(parts)
    end

    true
  end
end
