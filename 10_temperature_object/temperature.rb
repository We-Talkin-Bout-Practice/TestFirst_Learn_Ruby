class Temperature
  def initialize(options)
    @f = options[:f]
    @c = options[:c]
  end

  def in_fahrenheit
    @f || @c * (9.0/5.0) + 32
  end

  def in_celsius
    @c || (@f - 32) * (5.0/9.0)
  end

  def self.from_celsius(celsius)
    new(c: celsius)
  end

  def self.from_fahrenheit(fahrenheit)
    new(f: fahrenheit)
  end
end

class Celsius < Temperature
  def initialize(c)
    super(c: c)
  end
end

class Fahrenheit < Temperature
  def initialize(f)
    super(f: f)
  end
end
