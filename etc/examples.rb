require '../lib/accidently'

examples = <<EXAMPLES
[1,2,3].accidently == 3
[1,nil,3,5].accidently == [1,3,5]
[:a, :b, :c].accidently(:b) == 1
[:a, :b, :c, :d].accidently(2,3) == [:c, :d]
"abc".accidently(/\\w/) == ["a","b","c"]
[1,2,3,4,5].accidently{|a,b| a + b} == 15
EXAMPLES

examples.split("\n").each do |example|
  next if example.empty?
  puts "> #{example}\n => #{eval(example).inspect}"
  puts ""
end

1.accidently == '1'

[1,2,3].accidently(2) == [1,2]

