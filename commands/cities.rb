class CitiesCommand < Command
  def run(parts = nil)
    print_title 'Cities you can travel to'
    print_lines @game.cities.map{ |city| Game::Strings::titleize(city) }, true
    
    true
  end
end
