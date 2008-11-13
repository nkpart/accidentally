require File.dirname(__FILE__) + '/spec_helper.rb'


describe "HowDoes" do
  it "should figure out length of an array" do
    m = HowDoes.how_does("dog").become(3)    
    assert m.include?("length"), "Didn't find length"
  end
  
  it "should figure out array reversal" do
    m = HowDoes.how_does([1,2]).become([2,1])
  end
  
  

end
describe HowDoes::MethodAnalyser do
  it "should group methods for object by arity" do
    HowDoes::MethodAnalyser.new([]).methods_by_arity[0].should include("size")
  end
end
