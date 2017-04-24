require "./options/optionable"

module Game
  class Cities
    include Optionable

    AMSTERDAM = 'amsterdam'
    BANGKOK = 'bangkok'
    BARCELONA = 'barcelona'
    BERLIN = 'berlin'
    CHICAGO = 'chicago'
    HONG_KONG = 'hong kong'
    LAGOS = 'lagos'
    LIMA = 'lima'
    MEXICO_CITY = 'mexico city'
    MOSCOW = 'moscow'

    def self.normalize(city = '')
      case city
      when Symbol
        city = city.to_s
      end
      city.sub(/[^a-zA-Z]/, '_').upcase.to_sym
    end

    def self.find(city = '')
      self.include? self.normalize(city)
    end
  end
end
