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

  describe '#print' do
    let(:receipt) do
      <<~HEREDOC
        #{Time.now.strftime('%Y.%m.%d %H:%M:%S')}
        The Coffee Connection
        123 Lakeside Way
        Phone: +1 (650) 360-0708
        .
        Valid 01/01/2014 to 01/06/2014
        Table: 1 / [4]
        Max,Sam,Deb,Sarah
          Cafe Latte          1 x 4.75
          Flat White          2 x 4.75
          Cappucino           1 x 3.85
          Choc Mudcake        2 x 6.40
          Choc Mousse         1 x 8.20
          Affogato           1 x 14.80
          Tiramisu           1 x 11.40

        Disc            5% from $65.30
        Tax                      $5.64
        Total:                  $62.04
        Cash:                    70.00
        Change:                  $7.97

        Thank you!
      HEREDOC
    end

    it 'prints a bill' do
      order.add('Cafe Latte', 1)
      order.add('Flat White', 2)
      order.add('Cappucino', 1)
      order.add('Choc Mudcake', 2)
      order.add('Choc Mousse', 1)
      order.add('Affogato', 1)
      order.add('Tiramisu', 1)

      expect(order.print_bill).to eq(receipt)
    end
  end
end
