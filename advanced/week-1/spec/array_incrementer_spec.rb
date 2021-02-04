require '../class/array_incrementer.rb'

describe '#increment' do
  before (:all) do
    @incrementer = ArrayIncrementer.new
  end 

  context 'when input empty array' do
    it 'return [1] when input empty array' do
      result = @incrementer.increment([])
      expect(result).to eq([1])
    end
  end

  context 'when input single element array' do
    it 'return [1] when input [0]' do
      result = @incrementer.increment([0])
      expect(result).to eq([1])
    end
  
    it 'return [2] when input [1]' do
      result = @incrementer.increment([1])
      expect(result).to eq([2])
    end
  
    it 'return [3] when input [2]' do
      result = @incrementer.increment([2])
      expect(result).to eq([3])
    end
  
    it 'return [1, 0] when input [9]' do
      result = @incrementer.increment([9])
      expect(result).to eq([1, 0])
    end
  end

  context 'when input more than one element array' do
    it 'return [1, 1] when input [1, 0]' do
      result = @incrementer.increment([1, 0])
      expect(result).to eq([1, 1])
    end
  
    it 'return [2, 0] when input [1, 9]' do
      result = @incrementer.increment([1, 9])
      expect(result).to eq([2, 0])
    end

    it 'return [1, 1, 0] when input [1, 0, 9]' do
      result = @incrementer.increment([1, 0, 9])
      expect(result).to eq([1, 1, 0])
    end

    it 'return [1, 2, 1, 0] when input [1, 2, 0, 9]' do
      result = @incrementer.increment([1, 2, 0, 9])
      expect(result).to eq([1, 2, 1, 0])
    end

    it 'return [5, 6, 2] when input [5, 6, 1]' do
      result = @incrementer.increment([5, 6, 1])
      expect(result).to eq([5, 6, 2])
    end

    it 'return [4, 0] when input [3, 9]' do
      result = @incrementer.increment([3, 9])
      expect(result).to eq([4, 0])
    end

    it 'return [1, 0, 0] when input [9, 9]' do
      result = @incrementer.increment([9, 9])
      expect(result).to eq([1, 0, 0])
    end
  end
end