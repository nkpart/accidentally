require '../lib/how_does'

examples = <<EXAMPLES
[1,2,3].something == 3
[1,nil,3,5].something == [1,3,5]
[:a, :b, :c].something(:b) == 1
[:a, :b, :c, :d].something(2,3) == [:c, :d]
"abc".something(/\\w/) == ["a","b","c"]
[1,2,3,4,5].something{|a,b| a + b} == 15
EXAMPLES

examples.split("\n").each do |example|
  next if example.empty?
  puts "> #{example}\n => #{eval(example).inspect}"
  puts ""
end

1.something == '1'

[1,2,3].something(2) == [1,2]



