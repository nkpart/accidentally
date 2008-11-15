require File.dirname(__FILE__) + '/spec_helper.rb'


describe "HowDoes" do
  it "should figure out length of an array" do
    m = HowDoes.how_does("dog").become(3)
    assert m.include?("length")
  end
  
  it "should figure out array reversal" do
    m = HowDoes.how_does([1,2]).become([2,1])
    assert m.include?("reverse")
  end
  
  it "should figure out select" do
    m = HowDoes.how_does([1,false,2]).become([1,2])
    assert m.include?("select")
  end
end

describe HowDoes::MethodInvoker do
  it "should invoke a simple no args method" do
    r = HowDoes::MethodInvoker.invoke [], :size
    assert_equal 0, r
  end
  
  it "should invoke a no args method that takes a block" do
    r = HowDoes::MethodInvoker.invoke [1], :select
    assert_equal [1], r    
  end
end

describe "Kernel patches" do
  it "should have a better exception control mechanism" do
    my_fail = RuntimeError.new('fail test')
    res, ex = either {
      raise my_fail
    }
    res.should be_nil
    ex.should == my_fail
    
    res, ex = either {
      5
    }
    res.should == 5
    ex.should be_nil
  end
end