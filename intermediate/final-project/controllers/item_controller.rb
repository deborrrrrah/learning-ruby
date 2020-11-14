require './models/item.rb'
require './models/category.rb'
require './models/item_category.rb'

class ItemController
  def self.show(params)
    query = params['q'] == "" ? nil : params['q']
    if query.nil?
      items = Item.find_all
    else
      items = Item.filter_by_name(query)
    end
    renderer = ERB.new(File.read("./views/item/list.erb"))
    renderer.result(binding)
  end

  def self.detail(params) 
    item = Item.find_by_id(params['id'])
    categories = Category.find_all
    renderer = ERB.new(File.read("./views/item/detail.erb"))
    renderer.result(binding)
  end

  def self.new_form
    categories = Category.find_all
    renderer = ERB.new(File.read("./views/item/new.erb"))
    renderer.result(binding)
  end

  def self.edit_form(params)
    categories = Category.find_all
    item = Item.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/item/edit.erb"))
    renderer.result(binding)
  end

  def self.save_item_category(params)
    categories = Category.find_all
    categories.each do |category|
      key = 'category' + category.id.to_s
      item_category = ItemCategory.new({
        item_id: params['id'],
        category_id: category.id
      })
      if params.keys.include?(key)
        item_category.save
      else
        item_category.delete
      end
    end
  end

  def self.create(params)
    item = Item.new({
      name: params['name'],
      price: params['price']
    })
    item.save
    params['id'] = item.id
    save_item_category(params)
  end

  def self.update(params)
    item = Item.new({
      id: params['id'],
      name: params['name'],
      price: params['price']
    })
    item.save
    save_item_category(params)
  end

  def self.delete(params)
    item = Item.find_by_id(params['id'])
    item.delete
  end
end