require '../class/library.rb'

RSpec.describe 'Library' do
  describe '#valid?' do
    it 'return false when params is nil' do
      library = Library.new
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return true when shelf_size 3, row_size 2, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(true)
    end

    it 'return false when shelf_size 0, row_size 2, column_size 2' do
      params = {
        shelf_size: 0,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 100, row_size 2, column_size 2' do
      params = {
        shelf_size: 100,
        row_size: 2,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 0, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 0,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end

    it 'return false when shelf_size 3, row_size 100, column_size 2' do
      params = {
        shelf_size: 3,
        row_size: 100,
        column_size: 2
      }
      library = Library.new(params)
      result = library.valid?
      expect(result).to eq(false)
    end
  end
end