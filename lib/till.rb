# frozen_string_literal: true

class Till
  def initialize(menu:, order:, formatter:)
    @menu = menu
    @order = order
    @formatter = formatter
  end

  def show_menu
    menu.show
  end

  def add(item, quantity)
    order.add(item, quantity)
  end

  def checkout
    order.checkout
  end

  def print_bill
    formatter.text
  end

  private

  attr_reader :menu, :order, :formatter
end
