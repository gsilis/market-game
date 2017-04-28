class CitiesCommand < Command
  def run(parts = nil)
    print_title 'Cities you can travel to'
    print_lines @game.cities, true
    
    true
  end
end
