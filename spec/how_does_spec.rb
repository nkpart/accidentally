require File.dirname(__FILE__) + '/spec_helper.rb'

include HowDoes

describe HowDoes do
  it "should figure out length of an array" do
    methods = how_does("dog").become(3)
    assert methods.include?("length")
  end
  
  it "should figure out array reversal" do
    methods = how_does([1, 2]).become([2, 1])
    assert methods.include?("reverse")
  end
  
  it "should figure out select" do
    methods = how_does([1, false, 2]).become([1, 2])
    assert methods.include?("select")
  end
  
  it "should figure out index" do
    methods = how_does([:a, :b, :c]).become(:a)
    assert methods.include?("first")
  end
  
  it "should be able to be guided by a parameter" do
    methods = how_does([:a, :b, :c]).with(:b).become(1)
    assert methods.include?("index")
  end
  
  it "should be able to take a block suggestion" do
    b = proc { |a,b| a + b }
    m = HowDoes.how_does([1,2,3]).with(&b).become(6)
    assert m.include?("inject")
  end
end

describe "Howdy Doodie using cool hash syntax" do
  it "should figure out length of an array when there are no method arguments" do
    methods = howdy_doodie "dog" => 3
    assert methods.include?("length")
  end
  
  it "should work for hashes too" do
    methods = howdy_doodie({"dog" => 4} => 1)
    assert methods.include?("length")
  end  
end

describe "hd" do
  it "should be an alias of howdy_doodie" do
    methods = hd "dog" => 3
    assert methods.include?("length")    
  end
end

describe HowDoes::MethodInvoker do
  it "should invoke a simple no args method" do
    r = MethodInvoker.invoke [], :size, []
    assert_equal 0, r
  end
  
  it "should invoke a no args method that takes a block" do
    r = MethodInvoker.invoke [1], :select, []
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
  
  it "should collect warns" do
    a, warns = yield_and_collect_stderr {
      warn "fail"
      warn "2"
      5
    }
    
    a.should == 5
    warns.should == "fail\n2\n"
  end
end

describe "Thread patches" do
  it "should execute with a timeout" do
    Thread.execute_with_timeout(0.1) do
      5
    end.should == 5
  end
end
