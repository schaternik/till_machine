require 'json'

class Menu
  attr_reader :prices, :address, :shop_name, :phone_number

  def initialize(file_path)
    @file_path = file_path
    parse_menu
  end

  def show
    prices.each_with_index.inject('') do |menu, (item, i)|
      menu << "#{i + 1}. #{item[0]}: $#{'%.2f' % item[1]}\n"
    end
  end

  private

  def parse_menu
    file = File.read(@file_path)
    data = JSON.parse(file).first

    @prices = data['prices'].first
    @shop_name = data['shopName']
    @address = data['address']
    @phone_number = data['phone']
  end
end
