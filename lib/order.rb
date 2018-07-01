class Order
  attr_reader :basket

  def initialize
    @basket = {}
  end

  def add(item, quantity)
    return basket[item] += quantity if basket.has_key?(item)
    basket.merge!({ "#{item.to_s}" => quantity })
  end

  def checkout
    @menu ||= Menu.new('./data/menu.json')

    basket.keys.inject(0) do |total, item|
      total += @menu.items[item] * basket[item]
    end
  end

  def print_bill
    menu = JSON.parse(File.read('./data/menu.json'))
    BillFormatter.new(order: self, menu: menu).text
  end
end
