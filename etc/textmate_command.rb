#!/usr/bin/env ruby

require 'rubygems'
gem 'accidently'
require 'accidently'
input = STDIN.read
answers = eval(input)
if !answers.empty?
  puts "# #{input}"
  puts answers.map { |a|
    input.gsub(/accidently/, a)
  }.join("\n")
else
  puts $TM_SELECTED_TEXT + " # No match"
end

