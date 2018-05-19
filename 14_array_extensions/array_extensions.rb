class Array
  def sum
    inject(0) { |memo, num| memo += num }
  end

  def square
    map { |num| num * num }
  end

  def square!
    map! { |num| num * num }
  end
end
