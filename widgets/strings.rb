module Game
  class Strings
    def self.titleize(value)
      value.to_s.split('_').map(&:capitalize).join(' ')
    end

    def self.monetize(value)
      '$' + humanize(value)
    end

    def self.humanize(value)
      parts = []

      value.to_s.split('').reverse.each_with_index do |value, index|
        parts << ',' if index > 0 && index % 3 == 0
        parts << value
      end

      return parts.reverse.join('')
    end
  end
end
