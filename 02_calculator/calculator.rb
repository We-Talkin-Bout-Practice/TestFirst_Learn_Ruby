def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def sum(arr)
  arr.inject(0) { |num, memo| memo += num; memo }
end

def multiply(arr)
  arr.inject(1) { |num, memo| memo *= num; memo }
end

def power(a, b)
  a ** b
end

# def factorial(num)
#   if num == 0
#     1
#   else
#     num * factorial(num - 1)
#   end
# end

def factorial(num)
  range = num.downto(1).to_a
  multiply(range)
end
