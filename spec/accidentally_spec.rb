require File.dirname(__FILE__) + '/spec_helper.rb'

include Accidentally

describe Accidentally do
  it "should figure out length of an array" do
    methods = "dog".accidentally == 3
    assert methods.include?("length")
  end

  it "should figure out array reversal" do
    methods = [1, 2].accidentally == [2, 1]
    assert methods.include?("reverse")
  end
  
  it "should figure out select" do
    methods = [1, false, 2].accidentally == [1, 2]
    assert methods.include?("select { |x| x }")
  end
  
  it "should figure out index" do
    methods = [:a, :b, :c].accidentally == :a
    assert methods.include?("first")
  end
  
  it "should be able to be guided by a parameter" do
    methods = [:a, :b, :c].accidentally(:b) == 1
    assert methods.include?("index")
  end
  
  it "should be able to be guided by more than one parameter" do
    methods = [:a, :b, :c, :d, :e].accidentally(1, 2) == [:b, :c]
    assert methods.include?("slice")
  end

  it "should be able to take a block suggestion" do
    m = [1, 2, 3].accidentally{ |a, b| a + b } == 6
    assert m.include?("inject")
  end
  
  it "should not fail for fixnums" do
    m = 1.accidentally == "1"
    assert m.include?("to_s")
  end
end

describe Accidentally::MethodInvoker do
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
  
  it "should terminate early if longer than timeout" do
    Thread.execute_with_timeout(0.1) do sleep(0.2); 1 end.should == nil
  end
end



