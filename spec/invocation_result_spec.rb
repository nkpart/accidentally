require File.dirname(__FILE__) + '/spec_helper.rb'

include Accidentally

describe InvocationResult do
  it "should be equal to others" do
    InvocationResult.new(5, "b").should_not ==(InvocationResult.new(5))
    InvocationResult.new(3, "b").should_not ==(InvocationResult.new(5, "b"))
  end
  
end
