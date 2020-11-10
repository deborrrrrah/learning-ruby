require './models/item'
require './db/mysql_connector.rb'
require './models/helper/const_functions'

describe Item do
  describe 'non-db-related' do
    describe '#valid?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          item = Item.new({
            id: 1,  
            name: 'Bakso',
            price: '100.000'
          })
          expect(item.valid?).to eq(true)
        end
      end

      context 'when initialized with invalid minus price' do
        it 'should return false' do
          item = Item.new({
            id: 1,
            name: 'Bakso',
            price: '-100.000'
          })
          expect(item.valid?).to eq (false)
        end
      end

      context 'when initialized with invalid price' do
        it 'should return false' do
          item = Item.new({
            id: 1,
            name: 'Bakso',
            price: 'bakso harga 100.000'
          })
          expect(item.valid?).to eq (false)
        end
      end

      context 'when initialized with invalid name' do
        it 'should return false' do
          item = Item.new({
            id: 1,
            name: '',
            price: '100.000'
          })
          expect(item.valid?).to eq (false)
        end
      end

      context 'when initialized with new item format' do
        it 'should return false' do
          item = Item.new({
            name: 'Bakso',
            price: '100.000'
          })
          expect(item.valid?).to eq (true)
        end
      end
    end
    
    describe '#==' do 
      it 'should return true' do
        item_1 = Item.new({
          id: 1,  
          name: 'Bakso',
          price: '100.000'
        })
        item_2 = Item.new({
          id: 1,  
          name: 'Bakso',
          price: '100.000'
        })
        expect(item_1 == item_2).to eq(true)
      end

      it 'should return false' do
        item_1 = Item.new({
          id: 1,  
          name: 'Bakso',
          price: '100.000'
        })
        item_2 = Item.new({
          id: 1,  
          name: 'Bakso',
          price: '200.000'
        })
        expect(item_1 == item_2).to eq(false)
      end
    end

    describe '#to_s' do 
      it 'should return string' do 
        item = Item.new({
          id: 1,  
          name: 'Bakso',
          price: '100.000'
        })
        expect(item.to_s).to eq("Item @id = 1, @name = Bakso, @price = Rp100000")
      end

      it 'should return string without values' do
        item = Item.new({})
        expect(item.to_s).to eq("Item @id = , @name = , @price = ")
      end
    end
  end

  describe 'db-related' do
    before (:each) do
      client = create_db_client
      client.query("truncate table item_categories")
      client.query("set FOREIGN_KEY_CHECKS = 0")
      client.query("truncate table items")
      client.query("set FOREIGN_KEY_CHECKS = 1")
      client.close
    end

    describe 'when table is empty' do
      describe '.find_by_id' do
        it 'should return empty' do
          item = Item.find_by_id(1)
          expect(item).to eq(nil)
        end

        it 'should return empty' do
          item = Item.find_by_id(1)
          expect(item).not_to eq([Item.new({ id: 1, name: 'Bakso', price: '100000' })])
        end
      end
    
      describe '.find_all' do
        it 'should return empty' do
          items = Item.find_all
          expect(items).to eq([])
        end

        it 'should return empty' do
          items = Item.find_all
          expect(items).not_to eq([Item.new({ id: 1, name: 'Bakso', price: '100000' })])
        end
      end
    end

    describe 'when table is not empty' do
      before(:each) do
        client = create_db_client
        client.query('insert into items (name, price) values ("Bakso", 100000)')
        client.query('insert into items (name, price) values ("Kue", 50000)')
        client.query('insert into items (name, price) values ("Soda", 25000)')
        client.close
        @items = [
          Item.new({
            id: 1,
            name: 'Bakso',
            price: '100,000'
          }),
          Item.new({
            id: 2,
            name: 'Kue',
            price: '50,000'
          }),
          Item.new({
            id: 3,
            name: 'Soda',
            price: '25,000'
          })
        ]
      end

      describe '.convert_to_array' do
        it 'should return true list of items' do
          client = create_db_client
          raw_data = client.query("select id, name, format(price, 0) as price from items")
          client.close
          expect(Item.convert_to_array(raw_data)).to eq (@items)
        end

        it 'should return false because of empty' do
          client = create_db_client
          raw_data = client.query("select id, name, format(price, 0) as price from items")
          client.close
          expect(Item.convert_to_array(raw_data)).not_to eq ([])
        end
      end

      describe '.find_by_id' do
        it 'find by id 1 return item with id 1 should return true' do
          expected_item = @items[0]
          expect(Item.find_by_id(1)).to eq(expected_item)
        end

        it 'find by id 1 return item with id 2 should return false' do
          expected_item = @items[1]
          expect(Item.find_by_id(1)).not_to eq(expected_item)
        end
      end

      describe '.find_all' do
        it 'find all should return all' do
          expect(Item.find_all).to eq(@items)
        end
  
        it 'find all should not return one object' do
          expect(Item.find_all).not_to eq(@items[0])
        end
      end

      describe '#categories_to_s' do
        it 'return empty string because no items' do
          item = @items[0]
          expect(item.categories_to_s).to eq('')
        end
      end
  
      describe '#delete' do
        it 'should be deleted' do
          item = @items[0]
          response = item.delete
          deleted_item = Item.find_by_id(1)
          expect(deleted_item).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:delete_success])
        end

        it 'should be failed to delete due non-existing row' do
          item = Item.new({
            id: 4,
            name: 'Pizza',
            price: '150,000'
          })
          response = item.delete
          deleted_item = Item.find_by_id(4)
          expect(deleted_item).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:failed])
        end

        context 'existing item with id 4' do
          before(:each) do
            client = create_db_client
            client.query('insert into items (name, price) values ("Pizza", 150000)')
            client.close
            new_item = Item.new({
              id: 4,
              name: 'Pizza',
              price: '150,000'
            })
            @items << new_item
          end
          
          it 'should be failed to delete due not valid id' do
            item = Item.new({
              name: 'Pizza',
              price: '150,000'
            })
            response = item.delete
            deleted_item = Item.find_by_id(4)
            expect(deleted_item).to eq(@items[3]) 
            expect(response).to eq(CRUD_RESPONSE[:failed])
          end
  
          it 'should be failed to delete due not valid? return value' do
            item = Item.new({
              id: 4,
              name: '',
              price: '-150,000'
            })
            response = item.delete
            deleted_item = Item.find_by_id(4)
            expect(deleted_item).to eq(@items[3])
            expect(response).to eq(CRUD_RESPONSE[:failed])
          end
        end
      end
  
      describe '#save' do
        it 'should be created' do
          item = Item.new({
            name: 'Pizza',
            price: '150,000'
          })
          response = item.save
          added_item = Item.find_by_id(4)
          expect(added_item).to eq(Item.new({
            id: 4,
            name: 'Pizza',
            price: '150,000'
          })) 
          expect(response).to eq(CRUD_RESPONSE[:create_success])
        end

        it 'should be updated' do
          item = Item.new({
            id: 1,
            name: 'BaksoEnak',
            price: '100,000'
          })
          response = item.save
          updated_item = Item.find_by_id(1)
          expect(updated_item).to eq(item)
          expect(updated_item).not_to eq(@items[0])
          expect(response).to eq(CRUD_RESPONSE[:update_success])
        end

        it 'should be return already existed' do
          item = Item.new({
            name: 'Bakso',
            price: '100,000'
          })
          response = item.save
          expect(response).to eq(CRUD_RESPONSE[:already_existed])
        end

        it 'should be failed to create or update due not valid attributes' do
          item = Item.new({
            id: 1,
            name: 'BaksoEnak',
            price: '-100,000'
          })
          response = item.save
          saved_item = Item.find_by_id(4)
          expect(saved_item).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:failed])
        end
      end
    end
  end
end