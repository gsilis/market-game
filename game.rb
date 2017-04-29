require './options/cities'
require './widgets/account'
require './widgets/inventory'
require './widgets/location'
require './widgets/prices'
require './widgets/products'
require './widgets/wallet'
require './widgets/strings'

module Game
  class Game
    attr_reader :prices, :products, :filename

    def initialize(filename = nil, wallet = 100, account = 0, inventory = nil, location = nil, cycles = 0)
      location = location || Cities.random

      @filename = Time.now.strftime('%Y-%m-%d@%H:%m:%S')
      @wallet = Wallet.new wallet
      @account = Account.new account, 1.001
      @inventory = Inventory.new inventory
      @location = Location.new location
      @products = Products.new
      @cities = Products.new cities_as_products
      @prices = Prices.new @products.all
      @tickets = Prices.new @cities.all
      @cycles = cycles
      @waits = 0
    end

    def travel(city)
      city = Cities.normalize city
      price = ticket_for city
      return false unless Cities.include?(city)
      return false unless price > 0

      return false unless @wallet.debit(price)
      @location.name = city
      @cycles += 1
      @waits = 0
      reprice
      accrue_interest
      true
    end

    def reprice
      @prices = Prices.new @products.all
      @tickets = Prices.new @cities.all
      true
    end

    def wait
      @cycles += 1
      @waits += 1
      reprice
      accrue_interest
    end

    def buy(product_name, quantity = nil)
      return false unless @products.include?(product_name)
      current_funds = @wallet.balance
      price = @prices.price_for product_name
      quantity = current_funds / price if quantity.nil?
      amount = price * quantity
      return false unless @wallet.debit amount
      @inventory.update_for product_name, quantity
      true
    end

    def sell(product_name, quantity = nil)
      return false unless @products.include?(product_name)
      current_quantity = @inventory.count_for(product_name)
      quantity = current_quantity if quantity.nil?
      price = @prices.price_for(product_name)
      amount = price * quantity
      return false unless @inventory.update_for(product_name, -quantity)
      @wallet.credit amount
      true
    end

    def deposit(amount = nil)
      amount = @wallet.balance if amount.nil?
      return false unless @wallet.debit(amount)
      @account.credit amount
      true
    end

    def withdraw(amount = nil)
      amount = @account.balance if amount.nil?
      return false unless @account.debit(amount)
      @wallet.credit amount
      true
    end

    def cash
      @wallet.balance
    end

    def savings
      @account.balance
    end

    def stash
      @inventory.levels
    end

    def count_for(product_name)
      @inventory.count_for product_name
    end

    def price_for(product_name)
      @prices.price_for product_name
    end

    def ticket_for(city_name)
      @tickets.price_for city_name
    end

    def tickets
      @tickets
    end

    def city
      Strings::titleize @location.name
    end

    def cities
      Cities.all.map &:downcase
    end

    def to_json
      {
        wallet: @wallet.balance,
        account: @account.balance,
        location: @location.name,
        inventory: @inventory.levels,
      }
    end

    private
    def cities_as_products
      Cities.all.map do |city|
        Product.new city, 10..100
      end
    end

    def accrue_interest
      if @cycles % 4 == 0
        @account.accrue_interest
      end
    end
  end
end
