require './models/category'
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
        it 'find by id 1 return item with id 1 should return true' do
          expected_category = Category.new({
            id: 1,
            name: 'Main Dish'
          })
          expect(Category.find_by_id(1)).to eq(expected_category)
        end

        it 'find by id 1 return item with id 2 should return false' do
          expected_category = Category.new({
            id: 2,
            name: 'Beverages'
          })
          expect(Category.find_by_id(1)).not_to eq(expected_category)
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

      describe '#items_to_s' do
        it 'return empty string because no items' do
          category = Category.new({
            id: 1,
            name: 'Main Dish'
          })
          expect(category.items_to_s).to eq('')
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
          expect(response).to eq(CRUD_RESPONSE[:failed])
        end

        it 'should be failed to delete due not valid? return value' do
          category = Category.new({
            id: 4
          })
          response = category.delete
          deleted_category = Category.find_by_id(4)
          expect(deleted_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:failed])
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

        it 'should be failed to create or update' do
          category = Category.new({
            id: 4
          })
          response = category.save
          saved_category = Category.find_by_id(4)
          expect(saved_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:failed])
        end
      end
    end
  end
end