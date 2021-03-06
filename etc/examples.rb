require '../lib/accidentally'

examples = <<EXAMPLES
[1,2,3].accidentally == 3
[1,nil,3,5].accidentally == [1,3,5]
[:a, :b, :c].accidentally(:b) == 1
[:a, :b, :c, :d].accidentally(2,3) == [:c, :d]
"abc".accidentally(/\\w/) == ["a","b","c"]
[1,2,3,4,5].accidentally{|a,b| a + b} == 15
EXAMPLES

examples.split("\n").each do |example|
  next if example.empty?
  puts "> #{example}\n => #{eval(example).inspect}"
  puts ""
end

1.accidentally == '1'

[1,2,3].accidentally(2) == [1,2]

