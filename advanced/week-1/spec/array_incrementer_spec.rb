require '../class/array_incrementer.rb'

RSpec.describe "#increment" do
  it "return [1] when input empty array" do
    incrementer = ArrayIncrementer.new
    result = incrementer.increment([])
    expect(result).to eq([1])
  end
end