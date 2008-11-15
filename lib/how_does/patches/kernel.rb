module Kernel
  def either
    [yield, nil] 
  rescue Exception => e
    [nil, e]
  end
end
