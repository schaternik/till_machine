require 'menu'

describe Menu do
  describe '#initialize' do
    subject(:menu) { described_class.new('./data/menu.json') }

    let(:items) do
      {
        "Cafe Latte" => 4.75,
        "Flat White" => 4.75,
        "Cappucino" => 3.85,
        "Single Espresso" => 2.05,
        "Double Espresso" => 3.75,
        "Americano" => 3.75,
        "Cortado" => 4.55,
        "Tea" => 3.65,
        "Choc Mudcake" => 6.40,
        "Choc Mousse" => 8.20,
        "Affogato" => 14.80,
        "Tiramisu" => 11.40,
        "Blueberry Muffin" => 4.05,
        "Chocolate Chip Muffin" => 4.05,
        "Muffin Of The Day" => 4.55
      }
    end

    it 'has a list of items with prices' do
      expect(menu.items).to include(items)
    end
  end
end
