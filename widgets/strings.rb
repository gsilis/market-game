module Game
  class Strings
    def self.titleize(value)
      value.to_s.split('_').map(&:capitalize).join(' ')
    end
  end
end
