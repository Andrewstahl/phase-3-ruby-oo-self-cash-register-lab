require 'pry'

class CashRegister
  attr_accessor :discount, :total
  attr_reader :items, :transaction_list

  def initialize(discount = 0)
    @discount = discount
    @total = 0.0
    @items = []
    @transaction_list = []
  end

  def add_item(title, price, quantity = 1)
    # if quantity == 1
    #   # binding.pry
    #   self.items << title
    # else
    #   # binding.pry
    #   new_array = Array.new(quantity, title)
    #   self.items.concat new_array
    # end
    # binding.pry
    
    # Simplify this to just run the code once. This will
    # also allow us to create a transaction list array
    # that we can remove previous transactions
    transaction_items_array = Array.new(quantity, title)
    self.items.concat transaction_items_array
    transaction_cost = price * quantity
    self.total += (transaction_cost)
    # This will keep track of all incoming transactions so we 
    # can continue to void them continuously
    self.transaction_list.concat [[transaction_items_array, transaction_cost]]
    # binding.pry
  end

  def apply_discount
    case self.discount
    when 0
      "There is no discount to apply."
    else
      self.total = self.total * (1 - (self.discount / 100.0))
      # binding.pry
      # Need to transform it back to an integer
      "After the discount, the total comes to $#{self.total.to_i}."
    end
  end

  def void_last_transaction
    # The transaction_list is an array of elements, with each element
    # containing an array of items for that particular transaction and
    # the total cost of that transaction. Therefore, we'll need to always 
    # access the last element of the transaction_list array and remove
    # that from the items array and the total cost
    # if !self.items.empty? 
    # binding.pry
    last_transaction_items, last_transaction_cost = transaction_list.pop
    # Loops through each of the items in the last transaction items array
    # and deletes them from the object's items array
    last_transaction_items.each { |item| self.items.delete(item) }
    # Deletes the total transaction cost from the object's total
    self.total -= last_transaction_cost
    # end

  end

  # binding.pry

end