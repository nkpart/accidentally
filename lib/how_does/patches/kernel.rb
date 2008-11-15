module Kernel
  def either
    [yield, nil] 
  rescue Exception => e
    [nil, e]
  end
  
  def yield_and_collect_warns
    # so many lol effects
    old_err = $stderr
    $stderr = StringIO.new
    r = yield
    warns = $stderr.string
    [r, warns]
  ensure
    $stderr = old_err
  end
end
