require './models/item_category'
require './db/mysql_connector.rb'
require './models/helper/const_functions'

describe ItemCategory do
  describe 'non-db-related' do
    describe '#valid?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          item_category = ItemCategory.new({
            item_id: 1,  
            category_id: 2
          })
          expect(item_category.valid?).to eq(true)
        end
      end

      context 'when initialized with invalid category_id' do
        it 'should return false' do
          item_category = ItemCategory.new({
            item_id: 1
          })
          expect(item_category.valid?).to eq (false)
        end
      end

      context 'when initialized with invalid item_id' do
        it 'should return false' do
          item_category = ItemCategory.new({
            category_id: 2
          })
          expect(item_category.valid?).to eq (false)
        end
      end

      context 'when initialized with invalid item_id and category_id' do
        it 'should return false' do
          item_category = ItemCategory.new({})
          expect(item_category.valid?).to eq (false)
        end
      end
    end

    describe '#new?' do
      context 'when initialized with valid input' do 
        it 'should return true' do
          item_category = ItemCategory.new({
            item_id: 1,  
            category_id: 2
          })
          expect(item_category.new?).to eq(true)
        end
      end

      context 'when initialized with invalid item_id' do
        it 'should return false' do
          item_category = ItemCategory.new({
            category_id: 2
          })
          expect(item_category.new?).to eq (false)
        end
      end

      context 'when initialized with invalid category_id' do
        it 'should return false' do
          item_category = ItemCategory.new({
            item_id: 1
          })
          expect(item_category.new?).to eq (false)
        end
      end
    end

    describe '#==' do 
      it 'should return true' do
        item_category_1 = ItemCategory.new({
          item_id: 1,  
          category_id: 2
        })
        item_category_2 = ItemCategory.new({
          item_id: 1,  
          category_id: 2
        })
        expect(item_category_1 == item_category_2).to eq(true)
      end

      it 'should return false' do
        item_category_1 = ItemCategory.new({
          item_id: 1,  
          category_id: 2
        })
        item_category_2 = ItemCategory.new({
          item_id: 1,  
          category_id: 3
        })
        expect(item_category_1 == item_category_2).to eq(false)
      end
    end

    describe '#to_s' do 
      it 'should return string' do 
        item_category = ItemCategory.new({
          item_id: 1,  
          category_id: 3
        })
        expect(item_category.to_s).to eq("ItemCategory @item_id = 1, @category_id = 3")
      end

      it 'should return string without values' do
        item_category = ItemCategory.new({})
        expect(item_category.to_s).to eq("ItemCategory @item_id = , @category_id = ")
      end
    end
  end

  describe 'db-related' do
    before (:each) do
      client = create_db_client
      client.query("truncate table item_categories")
      client.close
    end

    describe 'when table is empty' do
      describe '.find_by_item_id' do
        it 'should return empty' do
          item_category = ItemCategory.find_by_item_id(1)
          expect(item_category).to eq([])
        end

        it 'should return empty' do
          item_category = ItemCategory.find_by_item_id(1)
          expect(item_category).not_to eq([ItemCategory.new({})])
        end
      end
    
      describe '.find_all' do
        it 'should return empty' do
          item_categories = ItemCategory.find_all
          expect(item_categories).to eq([])
        end

        it 'should return empty' do
          item_categories = ItemCategory.find_all
          expect(item_categories).not_to eq([ItemCategory.new({})])
        end
      end
    end

    describe 'when table is not empty' do
      before(:each) do
        client = create_db_client
        client.query('insert into item_categories (item_id, category_id) values (1,1)')
        client.query('insert into item_categories (item_id, category_id) values (2,2)')
        client.query('insert into item_categories (item_id, category_id) values (3,3)')
        client.close
        @item_categories = [
          ItemCategory.new({
            item_id: 1,
            category_id: 1
          }),
          ItemCategory.new({
            item_id: 2,
            category_id: 2
          }),
          ItemCategory.new({
            item_id: 3,
            category_id: 3
          })
        ]
      end

      describe '.convert_to_array' do
        it 'should return true list of item_categories' do
          client = create_db_client
          raw_data = client.query("select item_id, category_id from item_categories")
          client.close
          expect(ItemCategory.convert_to_array(raw_data)).to eq (@item_categories)
        end

        it 'should return false because of empty' do
          client = create_db_client
          raw_data = client.query("select item_id, category_id from item_categories")
          client.close
          expect(ItemCategory.convert_to_array(raw_data)).not_to eq ([])
        end
      end

      describe '.find_by_item_id' do
        it 'return item_category with item id 1 should return true' do
          expected_item_category = [@item_categories[0]]
          expect(ItemCategory.find_by_item_id(1)).to eq(expected_item_category)
        end

        it 'freturn item_category with item id 2 should return false' do
          expected_item_category = [@item_categories[1]]
          expect(ItemCategory.find_by_item_id(1)).not_to eq(expected_item_category)
        end
      end

      describe '.find_by_category_id' do
        it 'return item_category with category id 1 should return true' do
          expected_item_category = [@item_categories[0]]
          expect(ItemCategory.find_by_category_id(1)).to eq(expected_item_category)
        end

        it 'return item_category with category id 2 should return false' do
          expected_item_category = [@item_categories[0]]
          expect(ItemCategory.find_by_category_id(2)).not_to eq(expected_item_category)
        end
      end

      describe '.find_by_row' do
        it 'return item_category with item_id 1 and category_id 1 should return true' do
          expected_item_category = @item_categories[0]
          expect(ItemCategory.find_by_row({ item_id: 1, category_id: 1 })).to eq(expected_item_category)
        end

        it 'return item_category with item_id 1 and category_id 2 should return false' do
          expected_item_category = @item_categories[0]
          expect(ItemCategory.find_by_row({ item_id: 1, category_id: 2 })).not_to eq(expected_item_category)
        end
      end

      describe '.find_all' do
        it 'find all should return all' do
          expect(ItemCategory.find_all).to eq(@item_categories)
        end
  
        it 'find all should not return one object' do
          expect(ItemCategory.find_all).not_to eq(@item_categories[0])
        end
      end
  
      describe '#delete' do
        it 'should be deleted' do
          item_category = @item_categories[0]
          response = item_category.delete
          deleted_item_category = ItemCategory.find_by_row({ item_id: 1, category_id: 1 })
          expect(deleted_item_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:delete_success])
        end

        it 'should be failed to delete due non-existing row' do
          item_category = ItemCategory.new({
            item_id: 1,
            category_id: 2
          })
          response = item_category.delete
          deleted_item_category = ItemCategory.find_by_row({ item_id: 1, category_id: 2 })
          expect(deleted_item_category).to eq(nil) 
          expect(response).to eq(CRUD_RESPONSE[:failed])
        end

        context 'existing item with id 4' do
          before(:each) do
            client = create_db_client
            client.query('insert into item_categories (item_id, category_id) values (1, 2)')
            client.close
            new_item_category = ItemCategory.new({
              item_id: 1,
              category_id: 2
            })
            @item_categories << new_item_category
          end
          
          it 'should be failed to delete due not valid item id' do
            item_category = ItemCategory.new({
              item_id: nil,
              category_id: 2
            })
            response = item_category.delete
            deleted_item_category = ItemCategory.find_by_row({ item_id: 1, category_id: 2 })
            expect(deleted_item_category).to eq(@item_categories[3]) 
            expect(response).to eq(CRUD_RESPONSE[:invalid])
          end
        end
      end
  
      describe '#save' do
        it 'should be created' do
          item_category = ItemCategory.new({
            item_id: 1,
            category_id: 2
          })
          new_item_category = ItemCategory.new({
            item_id: 1,
            category_id: 2
          })
          response = item_category.save
          added_item_category = ItemCategory.find_by_row({ item_id: 1, category_id: 2 })
          expect(added_item_category).to eq(item_category) 
          expect(response).to eq(CRUD_RESPONSE[:create_success])
        end

        it 'should be return already existed' do
          item_category = ItemCategory.new({
            item_id: 1,
            category_id: 1
          })
          response = item_category.save
          expect(response).to eq(CRUD_RESPONSE[:already_existed])
        end
      end
    end
  end
end