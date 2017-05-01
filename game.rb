require './widgets/account'
require './widgets/inventory'
require './widgets/location'
require './widgets/prices'
require './widgets/products'
require './widgets/wallet'
require './widgets/strings'

module Game
  class Game
    attr_reader :prices, :filename

    def initialize(options = {})
      options = sanitize_options options

      account = options[:account]
      bought_items = options[:bought_items]
      cycles = options[:cycles]
      filename = options[:filename]
      interest_rate = options[:interest_rate]
      inventory = options[:inventory]
      location = options[:location]
      space = options[:space]
      wallet = options[:wallet]

      @account = Account.new account, interest_rate
      @bought_items = Inventory.new bought_items, -1
      @cycles = cycles
      @filename = filename
      @inventory = Inventory.new inventory, space
      @location = Location.new location
      @waits = 0
      @wallet = Wallet.new wallet

      reprice
    end

    def travel(city)
      city = cities.find_by_name city
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
      @prices = Prices.new products.all
      @store_prices = Prices.new store_items.all
      @tickets = Prices.new cities.all
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
      quantity = [current_funds / price, @inventory.available_space].min if quantity.nil?
      amount = price * quantity
      return false unless @inventory.has_space_for(quantity)
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

    def store_purchase(product_name, quantity = nil)
      product = @store_items.find_by_name product_name
      return false if product.nil?
      current_funds = @wallet.balance
      price = @store_prices.price_for product_name
      quantity = (current_funds / price) if quantity.nil?
      amount = price * quantity
      return false unless @wallet.debit amount
      product.apply_effect quantity
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

    def space
      [@inventory.item_count, @inventory.space]
    end

    def bought_items
      @bought_items.levels
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

    def store_price_for(store_item_name)
      @store_prices.price_for store_item_name
    end

    def city
      @location.city.title
    end

    def cities
      @cities ||= Products.new(default_cities)
      @cities
    end

    def products
      @products ||= Products.new(default_products)
      @products
    end

    def store_items
      @store_items ||= Products.new(default_store_items)
      @store_items
    end

    def to_json
      {
        account: @account.balance,
        bought_items: @bought_items.levels,
        cycles: @cycles,
        filename: @filename,
        inventory: @inventory.levels,
        interest_rate: @account.interest,
        location: @location.city,
        space: @inventory.space,
        wallet: @wallet.balance,
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
        Product.new('lorem', '', 1..10),
        Product.new('ipsum', '', 11..30),
        Product.new('sumet', '', 40..75),
        Product.new('donec', '', 100..150),
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
        Product.new city, '', 10..100
      end
    end

    def default_store_items
      [
        Product.new('backpack', '+5 slots', 5000..5000, @inventory) do |inventory, quantity|
          puts 'ADD SPACE'
          inventory.space += ( 5 * quantity )
        end,
        Product.new('bank', '+0.001 interest rate', 10000..10000, @account) do |account, quantity|
          account.interest += ( 0.001 * quantity )
        end,
      ]
    end

    def default_options
      {
        filename: Time.now.strftime('%Y-%m-%d@%H:%m:%S'),
        wallet: 1000000000,
        account: 0,
        interest_rate: 1.001,
        inventory: nil,
        space: 50,
        location: cities.all.sample,
        cycles: 0,
      }
    end

    def sanitize_options(options = {})
      default_options.merge(options.reject{ |key, val| val.nil? })
    end
  end
end
