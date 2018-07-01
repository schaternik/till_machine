require 'json'

class Menu
  attr_reader :items, :file_path

  def initialize(file_path)
    @file_path = file_path
    parse_menu_items
  end

  def show
    items.each_with_index.inject('') do |menu, (item, i)|
      menu << "#{i + 1}. #{item[0]}: $#{'%.2f' % item[1]}\n"
    end
  end

  private

  def parse_menu_items
    file = File.read(file_path)
    data = JSON.parse(file)
    @items = data.first['prices'].first
  end
end
