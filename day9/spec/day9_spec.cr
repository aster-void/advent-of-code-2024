require "./spec_helper"

describe Day9 do
  it "should solve part1" do
    content = File.read "./test.txt"
    Day9.part1(content).should eq(1928)
  end
  it "should solve part2" do
    content = File.read "./test.txt"
    Day9.part2(content).should eq(2858)
  end
end
