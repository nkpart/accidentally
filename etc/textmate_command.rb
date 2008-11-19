#!/usr/bin/env ruby

require 'rubygems'
gem 'nkpart-accidently'
require 'accidently'

selection = ENV['TM_SELECTED_TEXT']
answers = eval(selection)
if !answers.empty?
  puts "# #{selection}"
  puts answers.map { |a|
    selection.gsub(/accidently/, a)
  }.join("\n")
else
  puts ENV['TM_SELECTED_TEXT'] + " # No match"
end
