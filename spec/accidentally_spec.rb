require File.dirname(__FILE__) + '/spec_helper.rb'

include Accidentally

describe Accidentally do
  it "should figure out length of an array" do
    methods = "dog".accidentally == 3
    methods.should include("length")
  end

  it "should figure out array reversal" do
    methods = [1, 2].accidentally == [2, 1]
    methods.should include("reverse")
  end
  
  it "should figure out select" do
    methods = [1, false, 2].accidentally == [1, 2]
    methods.should include("select { |x| x }")
  end
  
  it "should figure out index" do
    methods = [:a, :b, :c].accidentally == :a
    methods.should include("first")
  end
  
  it "should be able to be guided by a parameter" do
    methods = [:a, :b, :c].accidentally(:b) == 1
    methods.should include("index")
  end
  
  it "should be able to be guided by more than one parameter" do
    methods = [:a, :b, :c, :d, :e].accidentally(1, 2) == [:b, :c]
    methods.should include("slice")
  end

  it "should be able to take a block suggestion" do
    m = [1, 2, 3].accidentally{ |a, b| a + b } == 6
    m.should include("inject")
  end
  
  it "should not fail for fixnums" do
    m = 1.accidentally == "1"
    m.should include("to_s")
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



