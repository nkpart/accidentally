class Object
  def what *args, &block
    HowDoes.how_does(self).with(*args, &block)
  end
  
  alias :something :what
end
