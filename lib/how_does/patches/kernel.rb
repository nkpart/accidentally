module Kernel
  
  # do error handling via the function Either[A, B] type, a little bit
  def either
    [yield, nil] 
  rescue Exception => e
    [nil, e]
  end
  
  
  def yield_and_collect_stderr
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
