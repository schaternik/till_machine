# frozen_string_literal: true

require 'order'
require 'menu'

describe Order do
  subject(:order) { described_class.new(menu: menu) }

  let(:menu) { Menu.new('./data/menu.json') }

  describe '#new' do
    it 'has an empty order basket' do
      expect(order.basket).to be_empty
    end
  end

  describe '#add' do
    let(:selected_products) do
      {
        'Tea' => 2,
        'Americano' => 1
      }
    end

    it 'adds menu item with its quantity' do
      create_order

      expect(order.basket).to eq(selected_products)
    end

    it 'adds a few products' do
      create_order

      expect(order.basket.size).to eq(2)
    end

    it 'summarizes quantity of a product in a cart' do
      order.add('Americano', 1)
      order.add('Americano', 1)

      expect(order.basket['Americano']).to eq(2)
    end
  end

  describe '#checkout' do
    it 'counts a total price' do
      create_order

      expect(order.checkout).to eq(11.05)
    end
  end

  def create_order
    order.add('Tea', 2)
    order.add('Americano', 1)
  end
end
