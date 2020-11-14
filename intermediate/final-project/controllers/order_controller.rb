require './models/order'

class OrderController
  def self.show
    orders = Order.find_all
    renderer = ERB.new(File.read("./views/order/list.erb"))
    renderer.result(binding)
  end

  def self.detail(params) 
    order = Order.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/order/detail.erb"))
    renderer.result(binding)
  end

  # def self.new_form
  #   renderer = ERB.new(File.read("./views/order/new.erb"))
  #   renderer.result(binding)
  # end

  # def self.edit_form(params)
  #   category = Category.find_by_id(params['id'])
  #   renderer = ERB.new(File.read("./views/order/edit.erb"))
  #   renderer.result(binding)
  # end

  # def self.delete_item_from_category(params)
  #   item_category = ItemCategory.find_by_row(params)
  #   item_category.delete
  # end

  # def self.create(params)
  #   category = Category.new({
  #     name: params['name'],
  #     price: params['price']
  #   })
  #   category.save
  # end

  # def self.update(params)
  #   category = Category.new({
  #     id: params['id'],
  #     name: params['name']
  #   })
  #   category.save
  # end

  # def self.delete(params)
  #   category = Category.find_by_id(params['id'])
  #   category.delete
  # end
end