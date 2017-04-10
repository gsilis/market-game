require './options/cities'
require './widgets/account'
require './widgets/inventory'
require './widgets/location'
require './widgets/prices'
require './widgets/products'
require './widgets/wallet'

module Game
  class Game
    attr_reader :prices, :products
    def initialize
      @wallet = Wallet.new 100
      @account = Account.new 0
      @inventory = Inventory.new
      @location = Location.new Cities.random
      @products = Products.new
      @prices = Prices.new @products.all
    end

    def travel(city)
      return false unless Cities.include?(city)

      @location.name = city
      @prices = Prices.new @products.all
      true
    end

    def buy(product_name, quantity)
      return false unless @products.include?(product_name)
      price = @prices.price_for product_name
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

    def city
      @location.name
    end
  end
end
