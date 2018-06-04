class Order
  attr_reader :basket

  def initialize
    @basket = []
  end

  def add(item, quantity)
    basket.push({ "#{item.to_s}" => quantity })
  end
end
