class CitiesCommand < Command
  def run(parts = nil)
    cities_lines = @game.cities.map do |city|
      city_price = @game.ticket_for city.name

      format_line [
        { text: city.title, padding: 20 },
        { text: Game::Strings.monetize(city_price), padding: 40, align: :right }
      ]
    end

    print_table [''] + cities_lines, true
    
    true
  end
end
