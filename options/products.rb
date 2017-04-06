require 'yaml'

module Game
  class Products
    def self.load
      @config ||= YAML.load_file './config/products.yml'
      result = verify_config
      @products = convert_to_products if result

      result
    end

    def self.verify_config
      products = @config['products']
      return false if products.nil?

      is_valid = true

      products.each do |product|
        is_valid = false unless verify_product(product)
      end

      is_valid
    end

    def self.verify_product(product)
      name = product['name']
      supply_range = Range.new *product['supply_range'].split('..')
      standard_range = Range.new *product['standard_range'].split('..')
      demand_range = Range.new *product['demand_range'].split('..')

      return false if name.nil? || supply_range.nil? || standard_range.nil? || demand_range.nil?
      return false if supply_range.max > standard_range.min || standard_range.max > demand_range.min

      true
    end

    def convert_to_products
      @config['products'].map{ |product| Product.new product }
    end

    def self.all
      @products
    end
  end

  class Product
    attr_accessor :name, :supply_range, :standard_range, :demand_range

    def initialize(product)
      @name = product[:name]
      @standard_range = Range.new *product['standard_range'].split('..')
      @supply_range = Range.new *product['supply_range'].split('..')
      @demand_range = Range.new *product['demand_range'].split('..')
    end
  end
end
