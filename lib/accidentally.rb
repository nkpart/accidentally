$: << File.expand_path(File.dirname(__FILE__))

require 'rubygems'
gem 'nkpart-prohax'
require 'prohax'
require 'accidentally/mad_hax'

class Object
  def accidentally *args, &block
    Accidentally::Proxy.new(self).with(*args, &block)
  end
end

module Accidentally
  VERSION = '0.0.2'

  class Proxy
    def initialize object
      @object = object
      @args = []
      @block = nil
    end

    def == result
      MadHax.find_how @object, result, @args, &@block
    end

    def with *args, &block
      @args.concat args
      @block = block
      self
    end
  end
end
