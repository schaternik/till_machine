require 'order'

describe Order do
  subject(:order) { described_class.new }

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

      expect(order.basket).to eq [selected_product]
    end

    it 'adds a few products' do
      order.add('Tea', 2)
      order.add('Americano', 1)

      expect(order.basket.size).to eq 2
    end
  end
end
