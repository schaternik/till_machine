# frozen_string_literal: true

require 'order'
require 'menu'

describe Order do
  let(:menu) { Menu.new('./data/menu.json') }
  subject(:order) { described_class.new(menu: menu) }

  describe '#new' do
    it 'has an empty order basket' do
      expect(order.basket).to be_empty
    end
  end

  describe '#add' do
    let(:selected_product) do
      { 'Tea' => 2 }
    end

    it 'adds menu item with its quantity' do
      order.add('Tea', 2)

      expect(order.basket).to eq selected_product
    end

    it 'adds a few products' do
      order.add('Tea', 2)
      order.add('Americano', 1)

      expect(order.basket.size).to eq 2
    end

    it 'summarizes quantity of a product in a cart' do
      order.add('Americano', 1)
      order.add('Americano', 1)

      expect(order.basket['Americano']).to eq 2
    end
  end

  describe '#checkout' do
    it 'counts a total price' do
      order.add('Tea', 2)
      order.add('Americano', 1)

      expect(order.checkout).to eq(11.05)
    end
  end
end
