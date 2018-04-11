require 'json'

class Menu
  attr_reader :items

  def initialize(file_path)
    parse_menu_items(file_path)
  end

  private

  def parse_menu_items(file_path)
    file = File.read(file_path)
    data = JSON.parse(file)
    @items = data.first['prices'].first
  end
end
