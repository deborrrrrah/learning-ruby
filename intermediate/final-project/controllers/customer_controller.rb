require './models/customer.rb'

class CustomerController
  def self.show(params)
    query = params['q'] == "" ? nil : params['q']
    if query.nil?
      customers = Customer.find_all
    else
      customers = Customer.filter_by_name(query)
    end
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