class Thread
  
  def self.execute_with_timeout(timeout = 0.5)
    r = nil
    t = Thread.new {
      r = yield 
    }
    t.join(timeout)
    r
  end
end
