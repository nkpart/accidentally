#!/usr/bin/env ruby

require 'rubygems'
gem 'how_does'
require 'how_does'
input = STDIN.read
answers = eval(input)
if !answers.empty?
  puts "# #{input}"
  puts answers.map { |a|
    input.gsub(/what/, a)
  }.join("\n")
else
  puts $TM_SELECTED_TEXT + " # No match"
end

