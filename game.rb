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
      @filename = filename || Time.now.strftime('%Y-%m-%d@%H:%m:%S')
      @wallet = Wallet.new wallet
      @account = Account.new account, 1.001
      @inventory = Inventory.new inventory
      @products = Products.new default_products
      @cities = Products.new default_cities
      @prices = Prices.new @products.all
      @tickets = Prices.new @cities.all
      @cycles = cycles
      @waits = 0
      @location = Location.new (location || @cities.all.sample)
    end

    def travel(city)
      city = @cities.find_by_name city
      return false if city.nil?

      price = ticket_for city.name
      return false unless price > 0

      return false unless @wallet.debit(price)
      @location.city = city
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

    def city
      @location.city.title
    end

    def cities
      @cities.all
    end

    def to_json
      {
        wallet: @wallet.balance,
        account: @account.balance,
        location: @location.city,
        inventory: @inventory.levels,
        cycles: @cycles,
      }
    end

    private
    def accrue_interest
      if @cycles % 4 == 0
        @account.accrue_interest
      end
    end

    def default_products
      [
        Product.new('lorem', 1..10),
        Product.new('ipsum', 11..30),
        Product.new('sumet', 40..75),
        Product.new('donec', 100..150)
      ]
    end

    def default_cities
      [
        'amsterdam',
        'bangkok',
        'barcelona',
        'berlin',
        'chicago',
        'hong kong',
        'lagos',
        'lima',
        'mexico city',
        'moscow'
      ].map do |city|
        Product.new city, 10..100
      end
    end
  end
end
