fibo = [ 0, 1 ]
loop do
  fibo_i = fibo[ -1 ] + fibo[ -2 ]
  break if fibo_i >= 100
  fibo << fibo_i
end
puts fibo
