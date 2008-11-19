
include Accidentally

describe Accidentally::MethodInvoker do
  it "should invoke a simple no args method" do
    r = MethodInvoker.invoke [], :size, []
    r.should == InvocationResult.new(0, nil)
  end
  
  it "should invoke a no args method that takes a block" do
    r = MethodInvoker.invoke [1], :select, []
    r.should == InvocationResult.new([1], "{ |x| x }")    
  end
end
