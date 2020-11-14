require './models/category'
require './models/item_category'
require './db/mysql_connector.rb'
require './models/helper/const_functions'

describe Category do
  describe 'non-db-related' do
    describe '#valid?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          category = Category.new({
            id: 1,  
            name: 'Main Dish'
          })
          expect(category.valid?).to eq(true)
        end
      end

      context 'when initialized with invalid input' do
        it 'should return false' do
          category = Category.new({
            id: 1
          })
          expect(category.valid?).to eq (false)
        end
      end
    end

    describe '#new?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          category = Category.new({ 
            name: 'Main Dish'
          })
          expect(category.new?).to eq(true)
        end
      end

      context 'when initialized with empty name' do
        it 'should return false' do
          category = Category.new({
            name: ''
          })
          expect(category.new?).to eq (false)
        end
      end

      context 'when initialized with nil' do
        it 'should return false' do
          category = Category.new({})
          expect(category.new?).to eq (false)
        end
      end
    end

    describe '#delete?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          category = Category.new({
            id: 1,  
            name: 'Main Dish'
          })
          expect(category.delete?).to eq(true)
        end
      end

      context 'when initialized with new format' do
        it 'should return false' do
          category = Category.new({  
            name: 'Main Dish'
          })
          expect(category.delete?).to eq (false)
        end
      end
    end
    
    describe '#==' do 
      it 'should return true' do
        category_1 = Category.new({
          id: 1,
          name: 'Main Dish'
        })
        category_2 = Category.new({
          id: 1,
          name: 'Main Dish'
        })
        expect(category_1 == category_2).to eq(true)
      end

      it 'should return false' do
        category_1 = Category.new({
          id: 1,
          name: 'Main Dish'
        })
        category_2 = Category.new({
          name: 'Main Dish'
        })
        expect(category_1 == category_2).to eq(false)
      end
    end

    describe '#to_s' do 
      it 'should return string' do 
        category = Category.new({
          id: 1,
          name: 'Main Dish'
        })
        expect(category.to_s).to eq("Category @id = 1, @name = Main Dish")
      end

      it 'should return string without values' do
        category = Category.new({})
        expect(category.to_s).to eq("Category @id = , @name = ")
      end
    end
  end
  describe 'db-related' do
    before (:each) do
      client = create_db_client
      client.query("truncate table item_categories")
      client.query("set FOREIGN_KEY_CHECKS = 0")
      client.query("truncate table categories")
      client.query("truncate table items")
      client.query("set FOREIGN_KEY_CHECKS = 1")
      client.close
    end

    describe 'when table is empty' do
      describe '.find_by_id' do
        it 'should return empty' do
          category = Category.find_by_id(1)
          expect(category).to eq(nil)
        end

        it 'should return empty' do
          category = Category.find_by_id(1)
          expect(category).not_to eq([Category.new({ id: 1, name: 'Main Dish'})])
        end
      end
    
      describe '.find_all' do
        it 'should return empty' do
          categories= Category.find_all
          expect(categories).to eq([])
        end

        it 'should return empty' do
          categories = Category.find_all
          expect(categories).not_to eq([Category.new({ id: 1, name: 'Main Dish'})])
        end
      end
    end

    describe 'when table is not empty' do
      before(:each) do
        client = create_db_client
        client.query('insert into categories (name) values ("Main Dish")')
        client.query('insert into categories (name) values ("Beverages")')
        client.query('insert into categories (name) values ("Dessert")')
        client.query('insert into items (name, price) values ("Bakso", 100000)')
        client.query('insert into items (name, price) values ("Kue", 50000)')
        client.query('insert into items (name, price) values ("Soda", 25000)')
        client.query('insert into items (name, price) values ("Fanta", 25000)')
        client.close
        @categories = [
          Category.new({
            id: 1,
            name: 'Main Dish'
          }),
          Category.new({
            id: 2,
            name: 'Beverages'
          }),
          Category.new({
            id: 3,
            name: 'Dessert'
          })
        ]
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
          }),
          Item.new({
            id: 4,
            name: 'Fanta',
            price: '25,000'
          })
        ]
      end

      describe '.convert_to_array' do
        it 'should return true list of categories' do
          client = create_db_client
          raw_data = client.query("select id, name from categories")
          client.close
          expect(Category.convert_to_array(raw_data)).to eq (@categories)
        end

        it 'should return false because of empty' do
          client = create_db_client
          raw_data = client.query("select id, name from categories")
          client.close
          expect(Category.convert_to_array(raw_data)).not_to eq ([])
        end
      end

      describe '.find_by_id' do
        it 'find by id 1 return category with id 1 should return true' do
          expected_category = @categories[0]
          expect(Category.find_by_id(1)).to eq(expected_category)
        end

        it 'find by id 1 return category with id 2 should return false' do
          expected_category = @categories[2]
          expect(Category.find_by_id(1)).not_to eq(expected_category)
        end
      end

      describe '.find_by_name' do
        it 'return category with name main dish should return true' do
          expected_category = @categories[0]
          expect(Category.find_by_name('main dish')).to eq(expected_category)
        end

        it 'find by id 1 return category with id 2 should return false' do
          expected_category = @categories[2]
          expect(Category.find_by_name('main dish')).not_to eq(expected_category)
        end
      end

      describe '.filter_by_name' do
        it 'return customer with keyword o should return true' do
          expected_category = [@categories[1], @categories[2]]
          expect(Category.filter_by_name('es')).to eq(expected_category)
        end

        it 'return category with keyword o should return false' do
          expected_category = @categories[1]
          expect(Category.filter_by_name('es')).not_to eq(expected_category)
        end
      end

      describe '.find_all' do
        it 'find all should return all' do
          expect(Category.find_all).to eq(@categories)
        end
  
        it 'find all should not return one object' do
          expect(Category.find_all).not_to eq(Category.new({ id: 1, name: 'Main Dish' }))
        end
      end

      context 'empty item_categories' do
        describe '#items' do
          it 'should return empty array for category with id 1' do
            category = @categories[0]
            expect(category.items).to eq([])
          end

          it 'should return empty array for invalid category' do
            category = Category.new({})
            expect(category.items).to eq([])
          end
        end

        describe '#items_to_s' do
          it 'return empty string because no items' do
            category = @categories[0]
            expect(category.items_to_s).to eq('No item')
          end
        end
      end

      context 'one item_categories' do
        before(:each) do
          client = create_db_client
          client.query('insert into item_categories (item_id, category_id) values (1, 1)')
          client.close
        end

        describe '#items' do
          it 'should return true array for category with id 1' do
            category = @categories[0]
            expect(category.items).to eq([@items[0]])
          end
        end

        describe '#items_to_s' do
          it 'return true string' do
            category = @categories[0]
            expect(category.items_to_s).to eq('Bakso')
          end
        end
      end

      context 'two item_categories' do
        before(:each) do
          client = create_db_client
          client.query('insert into item_categories (item_id, category_id) values (1, 1)')
          client.query('insert into item_categories (item_id, category_id) values (2, 1)')
          client.close
        end
        describe '#items' do
          it 'should return true array for category with id 1' do
            category = @categories[0]
            expect(category.items).to eq([@items[0], @items[1]])
          end
        end

        describe '#items_to_s' do
          it 'return true string' do
            category = @categories[0]
            expect(category.items_to_s).to eq('Bakso and Kue')
          end
        end
      end

      context 'three item_categories' do
        before(:each) do
          client = create_db_client
          client.query('insert into item_categories (item_id, category_id) values (1, 1)')
          client.query('insert into item_categories (item_id, category_id) values (2, 1)')
          client.query('insert into item_categories (item_id, category_id) values (3, 1)')
          client.close
        end
        describe '#items' do
          it 'should return true array for category with id 1' do
            category = @categories[0]
            expect(category.items).to eq([@items[0], @items[1], @items[2]])
          end
        end

        describe '#items_to_s' do
          it 'return true string' do
            category = @categories[0]
            expect(category.items_to_s).to eq('Bakso, Kue and Soda')
          end
        end
      end

      context 'four item_categories' do
        before(:each) do
          client = create_db_client
          client.query('insert into item_categories (item_id, category_id) values (1, 1)')
          client.query('insert into item_categories (item_id, category_id) values (2, 1)')
          client.query('insert into item_categories (item_id, category_id) values (3, 1)')
          client.query('insert into item_categories (item_id, category_id) values (4, 1)')
          client.close
        end

        describe '#items' do
          it 'should return true array for category with id 1' do
            category = @categories[0]
            expect(category.items).to eq([@items[0], @items[1], @items[2], @items[3]])
          end
        end

        describe '#items_to_s' do
          it 'return true string' do
            category = @categories[0]
            expect(category.items_to_s).to eq('Bakso, Kue, and 2 item(s)')
          end
        end
      end
  
      describe '#delete' do
        it 'should be deleted' do
          category = Category.find_by_id(1)
          response = category.delete
          deleted_category = Category.find_by_id(1)
          expect(deleted_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:delete_success])
        end

        it 'should be failed to delete due non-existing row' do
          category = Category.new({
            id: 4,
            name: 'Snack'
          })
          response = category.delete
          deleted_category = Category.find_by_id(4)
          expect(deleted_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:failed])
        end

        it 'should be failed to delete due not valid id' do
          category = Category.new({
            name: 'Snack'
          })
          response = category.delete
          deleted_category = Category.find_by_id(4)
          expect(deleted_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:invalid])
        end

        it 'should be failed to delete due not valid? return value' do
          category = Category.new({
            id: 4
          })
          response = category.delete
          deleted_category = Category.find_by_id(4)
          expect(deleted_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:invalid])
        end
      end
  
      describe '#save' do
        it 'should be created' do
          category = Category.new({
            name: 'Snack'
          })
          response = category.save
          added_category = Category.find_by_id(4)
          expect(added_category).to eq(Category.new({ id: 4, name: 'Snack' })) 
          expect(response).to eq(CRUD_RESPONSE[:create_success])
        end

        it 'should be updated' do
          category = Category.new({
            id: 1,
            name: 'Main Dish changed'
          })
          response = category.save
          updated_category = Category.find_by_id(1)
          expect(updated_category).to eq(category) 
          expect(response).to eq(CRUD_RESPONSE[:update_success])
        end

        it 'should be return already existed' do
          category = Category.new({
            name: 'Main Dish'
          })
          response = category.save
          expect(response).to eq(CRUD_RESPONSE[:already_existed])
        end

        it 'should be failed to create or update due not valid attributes' do
          category = Category.new({
            id: 4
          })
          response = category.save
          saved_category = Category.find_by_id(4)
          expect(saved_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:invalid])
        end
      end
    end
  end
end