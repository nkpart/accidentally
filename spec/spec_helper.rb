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
require 'accidentally'
require 'accidentally/method_invoker'
require 'accidentally/patches/kernel'
