#!/usr/bin/env ruby

require 'rubygems'
gem 'nkpart-accidentally'
require 'accidentally'

selection = ENV['TM_SELECTED_TEXT']
answers = eval(selection)
if !answers.empty?
  puts "# #{selection}"
  puts answers.map { |a|
    selection.gsub(/accidentally/, a)
  }.join("\n")
else
  puts ENV['TM_SELECTED_TEXT'] + " # No match"
end
