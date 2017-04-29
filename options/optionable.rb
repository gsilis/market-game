module Optionable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def all
      self.constants.reject do |name|
        name == :ClassMethods
      end
    end

    def random
      self.all.sample
    end

    def include?(value)
      self.all.include? value
    end
  end
end
