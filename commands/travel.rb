class TravelCommand < Command
  def run(parts)
    city_name = parts[0]

    if city_name && @game.travel(city_name)
      result("You are now in #{city_name}.", true)
    else
      result("Could not travel to '#{city_name}'. Try listing cities with the 'cities' command.", true)
    end

    true
  end
end
