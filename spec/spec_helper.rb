begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

require 'test/unit/assertions'

include Test::Unit::Assertions

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'how_does'
require 'how_does/method_invoker'
require 'how_does/patches/kernel'
require 'how_does/patches/symbol'
