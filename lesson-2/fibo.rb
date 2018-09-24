fibo = [0, 1]
i = 1
while fibo[i] < 100 - fibo[-2]
  i += 1
  fibo[i] = fibo[-1] + fibo[-2]
end
puts fibo
