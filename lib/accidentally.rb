$: << File.expand_path(File.dirname(__FILE__))

require 'rubygems'
gem 'nkpart-prohax'
require 'prohax'
require 'accidentally/mad_hax'

class Object
  def accidentally *args, &block
    Accidentally::Proxy.new(self, args, block)
  end
end

module Accidentally
  VERSION = '0.0.2'

  # syntactic sugar for Accidently.find_how 
  class Proxy
    def initialize object, args, block
      @object = object
      @args = args
      @block = block
    end

    def == result
      Accidentally.find_how @object, result, @args, &@block
    end
  end
end
