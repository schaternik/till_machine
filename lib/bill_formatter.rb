class BillFormatter
  attr_reader :order, :menu

  def initialize(order:, menu: menu)
    @order = order
    @menu = menu
  end

  def text
    menu1 = JSON.parse(File.read('./data/menu.json'))

    <<~BILL
      #{Time.now.strftime('%Y.%m.%d %H:%M:%S')}
      #{menu1.first['shopName']}
      #{menu1.first['address']}
      Phone: #{format_phone_number(menu1.first['phone'])}
      .
      Valid 01/01/2014 to 01/06/2014
      Table: 1 / [4]
      Max,Sam,Deb,Sarah
      #{print_basket_content}

      Disc            5% from $#{'%.2f' % order.checkout}
      Tax                      $#{'%.2f' % (0.0864 * order.checkout)}
      Total:                  $#{'%.2f' % (0.95 * order.checkout)}
      Cash:                    70.00
      Change:                  $7.97

      Thank you!
    BILL
  end

  private

  def format_phone_number(phone_number)
    if phone_number =~ /^(\d{1})(\d{3})(\d{3})(\d{4})$/
      "+#{$1} (#{$2}) #{$3}-#{$4}"
    else
      'Invalid input'
    end
  end

  def print_basket_content
    @menu1 ||= Menu.new('./data/menu.json')

    order.basket.inject('') do |output, item|
      name, quantity = item[0], item[1]
      price = '%.2f' % @menu1.prices[name]
      left_output = name.ljust(14)
      right_output = "#{quantity} x #{price}".rjust(14)
      output << "  #{left_output}#{right_output}\n"
    end.chomp
  end

end
