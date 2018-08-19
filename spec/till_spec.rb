require 'till'

describe Till do
  subject(:till) { described_class.new(menu: menu, order: order) }
  let(:menu) { Menu.new('./data/menu.json') }
  let(:order) { Order.new(menu: menu) }
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

  describe '#show_menu' do
    it 'shows menu' do
      expect(till.show_menu).to eq printed_menu
    end
  end

  describe '#add' do
    it 'adds item to the order' do
      till.add('Tea', 2)
      till.add('Americano', 1)

      expect(order.basket.size).to eq 2
    end
  end

  describe '#checkout' do
    it 'counts a total price' do
      order.add('Tea', 2)
      order.add('Americano', 1)

      expect(till.checkout).to eq(11.05)
    end
  end

  describe '#print_bill' do
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

      expect(till.print_bill).to eq(receipt)
    end
  end
end
