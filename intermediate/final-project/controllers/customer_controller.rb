require './models/customer.rb'
require './models/helper/const_functions.rb'

class CustomerController
  def self.show(params)
    query = params['q'] == "" ? nil : params['q']
    if query.nil?
      all_customers = Customer.find_all
    else
      all_customers = Customer.filter_by_name(query)
    end
    page = params[:page].nil? ? 1 : params[:page].to_i
    max_page = (all_customers.length().to_f / MAX_ITEM).ceil()
    customers = all_customers.slice((page - 1) * MAX_ITEM, MAX_ITEM)
    query = params['q']
    renderer = ERB.new(File.read("./views/customer/list.erb"))
    renderer.result(binding)
  end

  def self.detail(params) 
    customer = Customer.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/customer/detail.erb"))
    renderer.result(binding)
  end

  def self.new_form
    renderer = ERB.new(File.read("./views/customer/new.erb"))
    renderer.result(binding)
  end

  def self.edit_form(params)
    customer = Customer.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/customer/edit.erb"))
    renderer.result(binding)
  end

  def self.create(params)
    customer = Customer.new({
      name: params['name'],
      phone: params['phone']
    })
    customer.save
  end

  def self.update(params)
    customer = Customer.new({
      id: params['id'],
      name: params['name'],
      phone: params['phone']
    })
    customer.save
  end

  def self.delete(params)
    customer = Customer.find_by_id(params['id'])
    customer.delete
  end
end