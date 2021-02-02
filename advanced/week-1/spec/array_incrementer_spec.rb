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
end