require 'pry'
class RPNCalculator
  attr_accessor :stack

  def initialize
    @stack = []
  end

  def push(value)
    @stack.push(value)
  end

  def plus
    @stack.push(pop + pop)
  end

  def minus
    last = pop
    second_last = pop
    @stack.push(second_last - last)
  end

  def divide
    last = pop.to_f
    second_last = pop.to_f
    @stack.push(second_last / last)
  end

  def times
    @stack.push(pop * pop)
  end

  def value
    @stack.last
  end

  def pop
    element = @stack.pop
    raise "calculator is empty" if element.nil?
    element
  end

  def tokens(rpn_string)
    rpn_string.split.map do |t|
      case t
      when '+', '-', '*', '/'
        t.to_sym
      else
        t.to_f
      end
    end
  end

  def evaluate(rpn_string)
    tokenized_string = tokens(rpn_string)

    tokenized_string.each do |t|
      case t
      when :+
        plus
      when :-
        minus
      when :*
        times
      when :/
        divide
      else
        push(t)
      end
    end

    value
  end
end
