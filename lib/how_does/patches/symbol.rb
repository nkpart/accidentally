class Symbol
  def to_proc
    proc { |x|
      x.send(self)
    }  
  end
end