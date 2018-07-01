# frozen_string_literal: true

require 'menu'

describe Menu do
  subject(:menu) { described_class.new('./data/menu.json') }

  describe '#initialize' do
    let(:prices) do
      {
        'Cafe Latte' => 4.75,
        'Flat White' => 4.75,
        'Cappucino' => 3.85,
        'Single Espresso' => 2.05,
        'Double Espresso' => 3.75,
        'Americano' => 3.75,
        'Cortado' => 4.55,
        'Tea' => 3.65,
        'Choc Mudcake' => 6.40,
        'Choc Mousse' => 8.20,
        'Affogato' => 14.80,
        'Tiramisu' => 11.40,
        'Blueberry Muffin' => 4.05,
        'Chocolate Chip Muffin' => 4.05,
        'Muffin Of The Day' => 4.55
      }
    end
    let(:address) { '123 Lakeside Way' }
    let(:shop_name) { 'The Coffee Connection' }
    let(:phone_number) { '16503600708' }

    it 'has a list of items with prices' do
      expect(menu.prices).to include(prices)
    end

    it 'has a shop name' do
      expect(menu.shop_name).to eq(shop_name)
    end

    it 'has a shop address' do
      expect(menu.address).to eq(address)
    end

    it 'has a shop phone number' do
      expect(menu.phone_number).to eq(phone_number)
    end
  end

  describe '#show' do
    let(:printed_menu) do
      <<~HEREDOC
        1. Cafe Latte: $4.75
        2. Flat White: $4.75
        3. Cappucino: $3.85
        4. Single Espresso: $2.05
        5. Double Espresso: $3.75
        6. Americano: $3.75
        7. Cortado: $4.55
        8. Tea: $3.65
        9. Choc Mudcake: $6.40
        10. Choc Mousse: $8.20
        11. Affogato: $14.80
        12. Tiramisu: $11.40
        13. Blueberry Muffin: $4.05
        14. Chocolate Chip Muffin: $4.05
        15. Muffin Of The Day: $4.55
      HEREDOC
    end

    it 'shows a list of items' do
      expect(menu.show).to eq(printed_menu)
    end
  end
end
