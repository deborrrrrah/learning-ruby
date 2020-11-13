require './models/customer'
require './db/mysql_connector.rb'
require './models/helper/const_functions'

describe Customer do
  describe 'non-db-related' do
    describe '#valid?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          customer = Customer.new({
            id: 1,  
            name: 'Deborah',
            phone: '123456789012'
          })
          expect(customer.valid?).to eq(true)
        end
      end

      context 'when initialized with invalid name' do
        it 'should return false' do
          customer = Customer.new({
            id: 1,  
            name: '',
            phone: '123456789012'
          })
          expect(customer.valid?).to eq (false)
        end
      end

      context 'when initialized with invalid phone' do
        it 'should return false' do
          customer = Customer.new({
            id: 1,  
            name: 'Deborah',
            phone: '1234567890'
          })
          expect(customer.valid?).to eq (false)
        end
      end

      context 'when initialized with new customer format' do
        it 'should return false' do
          customer = Customer.new({
            name: 'Deborah',
            phone: '123456789012'
          })
          expect(customer.valid?).to eq (true)
        end
      end
    end

    describe '#new?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          customer = Customer.new({
            name: 'Deborah',
            phone: '123456789012'
          })
          expect(customer.new?).to eq(true)
        end
      end

      context 'when initialized with invalid phone' do
        it 'should return false' do
          customer = Customer.new({
            name: 'Deborah',
            phone: '1234567890'
          })
          expect(customer.new?).to eq (false)
        end
      end

      context 'when initialized with invalid name' do
        it 'should return false' do
          customer = Customer.new({
            name: '',
            phone: '123456789012'
          })
          expect(customer.new?).to eq (false)
        end
      end

      context 'when initialized with invalid name' do
        it 'should return false' do
          customer = Customer.new({
            phone: '123456789012'
          })
          expect(customer.new?).to eq (false)
        end
      end
    end

    describe '#delete?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          customer = Customer.new({
            id: 1,  
            name: 'Deborah',
            phone: '123456789012'
          })
          expect(customer.delete?).to eq(true)
        end
      end

      context 'when initialized with new format' do
        it 'should return false' do
          customer = Customer.new({
            name: 'Deborah',
            phone: '123456789012'
          })
          expect(customer.delete?).to eq (false)
        end
      end
    end
    
    describe '#==' do 
      it 'should return true' do
        customer_1 = Customer.new({
          id: 1,  
          name: 'Deborah',
          phone: '123456789012'
        })
        customer_2 = Customer.new({
          id: 1,  
          name: 'Deborah',
          phone: '123456789012'
        })
        expect(customer_1 == customer_2).to eq(true)
      end

      it 'should return false' do
        customer_1 = Customer.new({
          id: 1,  
          name: 'Deborah',
          phone: '123456789012'
        })
        customer_2 = Customer.new({
          id: 1,  
          name: 'DeborahAJ',
          phone: '123456789012'
        })
        expect(customer_1 == customer_2).to eq(false)
      end
    end

    describe '#to_s' do 
      it 'should return string' do 
        customer = Customer.new({
          id: 1,  
          name: 'Deborah',
          phone: '123456789012'
        })
        expect(customer.to_s).to eq("Customer @id = 1, @name = Deborah, @phone = 123456789012")
      end

      it 'should return string without values' do
        customer = Customer.new({})
        expect(customer.to_s).to eq("Customer @id = , @name = , @phone = ")
      end
    end
  end

  describe 'db-related' do
    before (:each) do
      client = create_db_client
      client.query("set FOREIGN_KEY_CHECKS = 0")
      client.query("truncate table orders")
      client.query("truncate table customers")
      client.query("set FOREIGN_KEY_CHECKS = 1")
      client.close
    end

    describe 'when table is empty' do
      describe '.find_by_id' do
        it 'should return empty' do
          customer = Customer.find_by_id(1)
          expect(customer).to eq(nil)
        end

        it 'should return empty' do
          customer = Customer.find_by_id(1)
          expect(customer).not_to eq([Customer.new({ id: 1, name: 'Deborah', phone: '123456789012' })])
        end
      end
    
      describe '.find_all' do
        it 'should return empty' do
          customers = Customer.find_all
          expect(customers).to eq([])
        end

        it 'should return empty' do
          customers = Customer.find_all
          expect(customers).not_to eq([Customer.new({ id: 1, name: 'Deborah', phone: '123456789012' })])
        end
      end
    end

    describe 'when table is not empty' do
      before(:each) do
        client = create_db_client
        client.query('insert into customers (name, phone) values ("Deborah", "123456789012")')
        client.query('insert into customers (name, phone) values ("Jon", "000011112222")')
        client.query('insert into customers (name, phone) values ("Arya", "333344445555")')
        client.close
        @customers = [
          Customer.new({
            id: 1,
            name: 'Deborah',
            phone: '123456789012'
          }),
          Customer.new({
            id: 2,
            name: 'Jon',
            phone: '000011112222'
          }),
          Customer.new({
            id: 3,
            name: 'Arya',
            phone: '333344445555'
          })
        ]
      end

      describe '.convert_to_array' do
        it 'should return true list of customers' do
          client = create_db_client
          raw_data = client.query("select id, name, phone as phone from customers")
          client.close
          expect(Customer.convert_to_array(raw_data)).to eq (@customers)
        end

        it 'should return false because of empty' do
          client = create_db_client
          raw_data = client.query("select id, name, phone from customers")
          client.close
          expect(Customer.convert_to_array(raw_data)).not_to eq ([])
        end
      end

      describe '.find_by_id' do
        it 'find by id 1 return customer with id 1 should return true' do
          expected_customer = @customers[0]
          expect(Customer.find_by_id(1)).to eq(expected_customer)
        end

        it 'find by id 1 return customer with id 2 should return false' do
          expected_customer = @customers[1]
          expect(Customer.find_by_id(1)).not_to eq(expected_customer)
        end
      end

      describe '.find_by_name' do
        it 'return customer with name deborah should return true' do
          expected_customer = @customers[0]
          expect(Customer.find_by_name('Deborah')).to eq(expected_customer)
        end

        it 'return customer with name deborah should return false' do
          expected_customer = @customers[1]
          expect(Customer.find_by_name('Deborah')).not_to eq(expected_customer)
        end
      end

      describe '.find_by_phone' do
        it 'return customer phone 123456789012 should return true' do
          expected_customer = @customers[0]
          expect(Customer.find_by_phone('123456789012')).to eq(expected_customer)
        end

        it 'return customer phone 123456789012 should return false' do
          expected_customer = @customers[1]
          expect(Customer.find_by_phone('123456789012')).not_to eq(expected_customer)
        end
      end

      describe '.filter_by_name' do
        it 'return customer with keyword o should return true' do
          expected_customer = [@customers[0], @customers[1]]
          expect(Customer.filter_by_name('o')).to eq(expected_customer)
        end

        it 'return customer with keyword o should return false' do
          expected_customer = @customers[1]
          expect(Customer.filter_by_name('o')).not_to eq(expected_customer)
        end
      end

      describe '.find_all' do
        it 'find all should return all' do
          expect(Customer.find_all).to eq(@customers)
        end
  
        it 'find all should not return one object' do
          expect(Customer.find_all).not_to eq(@customers[0])
        end
      end

      describe '#orders_to_s' do
        it 'return empty string because no customers' do
          customer = @customers[0]
          expect(customer.orders_to_s).to eq('')
        end
      end
  
      describe '#delete' do
        it 'should be deleted' do
          customer = @customers[0]
          response = customer.delete
          deleted_customer = Customer.find_by_id(1)
          expect(deleted_customer).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:delete_success])
        end

        it 'should be failed to delete due non-existing row' do
          customer = Customer.new({
            id: 4,
            name: 'Cersei',
            phone: '666677778888'
          })
          response = customer.delete
          deleted_customer = Customer.find_by_id(4)
          expect(deleted_customer).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:failed])
        end

        context 'existing customer with id 4' do
          before(:each) do
            client = create_db_client
            client.query('insert into customers (name, phone) values ("Cersei", "666677778888")')
            client.close
            new_customer = Customer.new({
              id: 4,
              name: 'Cersei',
              phone: '666677778888'
            })
            @customers << new_customer
            @customers.sort_by(&:id)
          end
          
          it 'should be failed to delete due not valid id' do
            customer = Customer.new({
              name: 'Cersei',
              phone: '666677778888'
            })
            response = customer.delete
            deleted_customer = Customer.find_by_id(4)
            expect(deleted_customer).to eq(@customers[3]) 
            expect(response).to eq(CRUD_RESPONSE[:invalid])
          end
  
          it 'should be failed to delete due not valid? return value' do
            customer = Customer.new({
              id: 4,
              name: 'Cersei',
              phone: '66667777'
            })
            response = customer.delete
            deleted_customer = Customer.find_by_id(4)
            expect(deleted_customer).to eq(@customers[3])
            expect(response).to eq(CRUD_RESPONSE[:invalid])
          end
        end
      end
  
      describe '#save' do
        it 'should be created' do
          customer = Customer.new({
            name: 'Cersei',
            phone: '666677778888'
          })
          new_customer = Customer.new({
            id: 4,
            name: 'Cersei',
            phone: '666677778888'
          })
          response = customer.save
          added_customer = Customer.find_by_id(4)
          expect(added_customer).to eq(new_customer) 
          expect(response).to eq(CRUD_RESPONSE[:create_success])
        end

        it 'should be updated' do
          customer = Customer.new({
            id: 1,
            name: 'CerseiLannister',
            phone: '6666777788889'
          })
          response = customer.save
          updated_customer = Customer.find_by_id(1)
          expect(response).to eq(CRUD_RESPONSE[:update_success])
          expect(updated_customer).to eq(customer)
        end

        it 'should be return already existed' do
          customer = Customer.new({
            name: 'Deborah',
            phone: '123456789012'
          })
          response = customer.save
          expect(response).to eq(CRUD_RESPONSE[:already_existed])
        end

        it 'should be failed to create or update due not valid attributes' do
          customer = Customer.new({
            id: 1,
            name: 'Deborah',
            phone: '1234567890'
          })
          response = customer.save
          saved_customer = Customer.find_by_id(4)
          expect(saved_customer).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:invalid])
        end
      end
    end
  end
end