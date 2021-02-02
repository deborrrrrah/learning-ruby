require '../class/array_incrementer.rb'

RSpec.describe "#increment" do
  it "return [1] when input empty array" do
    incrementer = ArrayIncrementer.new
    result = incrementer.increment([])
    expect(result).to eq([1])
  end

  it "return [1] when input [0]" do
    incrementer = ArrayIncrementer.new
    result = incrementer.increment([0])
    expect(result).to eq([1])
  end
end