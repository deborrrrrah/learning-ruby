require 'sinatra'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './controllers/customer_controller.rb'
require './controllers/order_controller.rb'

get '/' do 
  redirect '/items'
end

get '/items' do
  ItemController.show(params)
end

get '/items/page/:page' do
  ItemController.show(params)
end

get '/categories' do
  CategoryController.show(params)
end

get '/categories/page/:page' do
  CategoryController.show(params)
end

get '/customers' do
  CustomerController.show(params)
end

get '/customers/page/:page' do
  CustomerController.show(params)
end

get '/orders' do
  OrderController.show(params)
end

get '/orders/page/:page' do
  OrderController.show(params)
end

get '/cart' do
  OrderController.show_cart
end

post '/cart/submit' do
  id = OrderController.save_cart(params)
  redirect "/orders/detail/#{ id }"
end

get '/cart/remove-all' do
  OrderController.delete_items
  redirect '/cart'
end

get '/cart/delete/:item_id' do
  OrderController.delete_item(params)
  redirect '/cart'
end

get '/cart/add/:item_id' do
  OrderController.add_item(params)
  redirect '/items'
end

get '/items/detail/:id' do
  ItemController.detail(params)
end

get '/customers/detail/:id' do
  CustomerController.detail(params)
end

get '/categories/detail/:id' do
  CategoryController.detail(params)
end

get '/orders/detail/:id' do
  OrderController.detail(params)
end

get '/categories/detail/:category_id/delete-item/:item_id' do
  CategoryController.delete_item_from_category(params)
  redirect "/categories/detail/#{ params['category_id'] }"
end

get '/items/delete/:id' do
  response = ItemController.delete(params)
  redirect '/items'
end

get '/categories/delete/:id' do
  response = CategoryController.delete(params)
  redirect '/categories'
end

get '/customers/delete/:id' do
  response = CustomerController.delete(params)
  redirect '/customers'
end

get '/items/new' do
  controller = ItemController.new_form
end

get '/customers/new' do
  controller = CustomerController.new_form
end

get '/categories/new' do
  controller = CategoryController.new_form
end

post '/items/create' do
  controller = ItemController.create(params)
  redirect '/items'
end

post '/customers/create' do
  controller = CustomerController.create(params)
  redirect '/customers'
end

post '/categories/create' do
  controller = CategoryController.create(params)
  redirect '/categories'
end

get '/items/edit/:id' do 
  controller = ItemController.edit_form(params)
end

get '/categories/edit/:id' do 
  controller = CategoryController.edit_form(params)
end

get '/customers/edit/:id' do 
  controller = CustomerController.edit_form(params)
end

post '/items/update/:id' do
  controller = ItemController.update(params)
  redirect '/items'
end

post '/categories/update/:id' do
  controller = CategoryController.update(params)
  redirect '/categories'
end

post '/customers/update/:id' do
  controller = CustomerController.update(params)
  redirect '/customers'
end