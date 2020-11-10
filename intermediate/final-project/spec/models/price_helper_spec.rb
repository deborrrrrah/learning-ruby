require './models/helper/price'

describe Price do
  describe  '#valid?' do
    it 'should return true' do
      price = Price.new('100.000')
      expect(price.valid?).to eq(true)
    end

    it 'should return true' do
      price = Price.new('0')
      expect(price.valid?).to eq(true)
    end
    
    it 'should return false' do
      price = Price.new('-100000')
      expect(price.valid?).to eq(false)
    end

    it 'should return false' do
      price = Price.new('ap')
      expect(price.valid?).to eq(false)
    end
  end
  describe  '#to_s?' do
    it 'should return Rp100000' do
      price = Price.new('100.000')
      expect(price.to_s).to eq('Rp100000')
    end

    it 'should return Rp0' do
      price = Price.new('0')
      expect(price.to_s).to eq('Rp0')
    end
    
    it 'should return empty string' do
      price = Price.new('-100000')
      expect(price.to_s).to eq('')
    end

    it 'should return empty string' do
      price = Price.new('ap')
      expect(price.to_s).to eq('')
    end
  end
end