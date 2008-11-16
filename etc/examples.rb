require '../lib/how_does'

examples = <<EXAMPLES
[1,2,3].what == 3
[1,false,3,5].what == [1,3,5]
[:a, :b, :c].what(:b) == 1
[:a, :b, :c, :d].what(2,3) == [:c, :d]
"abc".what(/\\w/) == ["a","b","c"]
[1,2,3,4,5].what{|a,b| a + b} == 15
EXAMPLES

examples.split("\n").each do |example|
  next if example.empty?
  puts "> #{example}\n => #{eval(example).inspect}"
  puts ""
end

1.what == '1'
[1,2,3].what(2) == [1,2]

