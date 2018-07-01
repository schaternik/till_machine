class Till
  def initialize(menu: menu, order: order)
    @menu = menu
    @order = order
  end

  def show_menu
    @menu.show
  end

  def add(item, quantity)
    @order.add(item, quantity)
  end

  def checkout
    @order.checkout
  end

  def print_bill
    @order.print_bill
  end
end
