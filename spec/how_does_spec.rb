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
  
  it "should be able to be guided by more than one parameter" do
    methods = how_does([:a, :b, :c, :d, :e]).with(1, 2).become([:b, :c])
    assert methods.include?("slice")
  end

  it "should figure out length of an array even using an empty with" do
    methods = how_does("dog").with().become(3)
    assert methods.include?("length")
  end
  
  it "should be able to take a block suggestion" do
    m = how_does([1, 2, 3]).with{ |a, b| a + b }.become(6)
    assert m.include?("inject")
  end
end

describe "Object with how_does monkey patch" do
  it "should figure out length of an array" do
    methods = "dog".what == 3
    assert methods.include?("length")
  end
  
  it "should work for hashes too" do
    methods = {"dog" => 4}.what == 1
    assert methods.include?("length")
  end

  it "should be able to be guided by a parameter" do
    methods = [:a, :b, :c].what(:b) == 1
    assert methods.include?("index")
  end
  
  it "should be able to be guided by more than one parameter" do
    methods = [:a, :b, :c, :d, :e].what(1, 2) == [:b, :c]
    assert methods.include?("slice")
  end

  it "should be able to take a block suggestion" do
    m = [1, 2, 3].what{ |a, b| a + b } == 6
    assert m.include?("inject")
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



