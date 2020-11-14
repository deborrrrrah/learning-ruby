require './models/category.rb'
require './models/item_category.rb'

class CategoryController
  def self.show(params)
    if params['query'] == ""
      categories = Category.find_all
    else
      categories = Category.filter_by_name(params['query'])
    end
    renderer = ERB.new(File.read("./views/category/list.erb"))
    renderer.result(binding)
  end

  def self.detail(params) 
    category = Category.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/category/detail.erb"))
    renderer.result(binding)
  end

  def self.new_form
    renderer = ERB.new(File.read("./views/category/new.erb"))
    renderer.result(binding)
  end

  def self.edit_form(params)
    category = Category.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/category/edit.erb"))
    renderer.result(binding)
  end

  def self.delete_item_from_category(params)
    item_category = ItemCategory.find_by_row(params)
    item_category.delete
  end

  def self.create(params)
    category = Category.new({
      name: params['name'],
      price: params['price']
    })
    category.save
  end

  def self.update(params)
    category = Category.new({
      id: params['id'],
      name: params['name']
    })
    category.save
  end

  def self.delete(params)
    category = Category.find_by_id(params['id'])
    category.delete
  end
end