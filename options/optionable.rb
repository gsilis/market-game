module Optionable
  def self.all
    self.constants
  end

  def self.random
    all.sample
  end
end
