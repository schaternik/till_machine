class BillFormatter
  attr_reader :order, :menu

  def initialize(order:, menu:)
    @order = order
    @menu = menu
  end

  def text
    <<~BILL
      #{Time.now.strftime('%Y.%m.%d %H:%M:%S')}
      #{menu.shop_name}
      #{menu.address}
      Phone: #{format_phone_number(menu.phone_number)}
      .
      Valid 01/01/2014 to 01/06/2014
      Table: 1 / [4]
      Max,Sam,Deb,Sarah
      #{print_basket_content}

      Disc            5% from $#{format('%.2f', order.checkout)}
      Tax                      $#{format('%.2f', (0.0864 * order.checkout))}
      Total:                  $#{format('%.2f', (0.95 * order.checkout))}
      Cash:                    70.00
      Change:                  $7.97

      Thank you!
    BILL
  end

  private

  def format_phone_number(phone_number)
    if phone_number =~ /^(\d{1})(\d{3})(\d{3})(\d{4})$/
      "+#{Regexp.last_match(1)} (#{Regexp.last_match(2)}) #{Regexp.last_match(3)}-#{Regexp.last_match(4)}"
    else
      'Invalid input'
    end
  end

  def print_basket_content
    order.basket.inject('') do |output, item|
      name = item[0]
      quantity = item[1]
      price = format('%.2f', menu.prices[name])
      left_output = name.ljust(14)
      right_output = "#{quantity} x #{price}".rjust(14)
      output << "  #{left_output}#{right_output}\n"
    end.chomp
  end
end
