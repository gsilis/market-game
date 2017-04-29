class TravelCommand < Command
  def run(parts)
    city_name = parts.join('_')

    if city_name && @game.travel(city_name)
      result("You are now in #{city_name}.")
      PricesCommand.new(@system, @game).run(parts)
    else
      result("Could not travel to '#{city_name}'. Try listing cities with the 'cities' command.", true)
    end

    true
  end
end
