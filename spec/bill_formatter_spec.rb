# frozen_string_literal: true

require 'bill_formatter'

describe BillFormatter do
  subject(:bill_formatter) { described_class.new(order: order, menu: menu) }
  let(:menu) { Menu.new('./data/menu.json') }
  let(:order) { Order.new(menu: menu) }
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

  before do
    order.add('Cafe Latte', 1)
    order.add('Flat White', 2)
    order.add('Cappucino', 1)
    order.add('Choc Mudcake', 2)
    order.add('Choc Mousse', 1)
    order.add('Affogato', 1)
    order.add('Tiramisu', 1)
  end

  it 'formats a printed bill' do
    printed_bill = bill_formatter.text

    expect(printed_bill).to eq(receipt)
  end
end
