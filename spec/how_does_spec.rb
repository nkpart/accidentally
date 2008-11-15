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
    b = proc { |a, b| a + b }
    m = HowDoes.how_does([1, 2, 3]).with(&b).become(6)
    assert m.include?("inject")
  end
end

describe "Object with how_does monkey patch" do
  it "should figure out length of an array" do
    methods = "dog".what.returns 3
    assert methods.include?("length")
  end
  
  it "should work for hashes too" do
    methods = {"dog" => 4}.what.returns 1
    assert methods.include?("length")
  end

  it "should be able to be guided by a parameter" do
    methods = [:a, :b, :c].what(:b).returns(1)
    assert methods.include?("index")
  end
  
  it "should be able to be guided by more than one parameter" do
    methods = [:a, :b, :c, :d, :e].what(1, 2).returns([:b, :c])
    assert methods.include?("slice")
  end

  it "should be able to take a block suggestion" do
    b = proc { |a, b| a + b }
    m = HowDoes.how_does([1, 2, 3]).with(&b).returns(6)
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

describe "Haskell ruby" do
  it "should be let-like and in-ish" do
    let(:foo => 5 ).in { foo }.should == 5
  end
  
  it "should be mad" do
    x = 5
    let(
      :plus => proc { |a,b| a + b },
      :times => proc { |a,b| a * b },
      :five => proc { 5 },
      :fast_five => 5
    ).in { 
      plus(x, times(five, plus(1, fast_five)))
    }.should == 35
  end
end


