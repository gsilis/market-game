module Optionable
  def self.included(base)
    base.extend(ClassMethods)
    puts "included"
  end

  module ClassMethods
    def all
      self.constants
    end

    def random
      self.all.sample
    end
  end
end
