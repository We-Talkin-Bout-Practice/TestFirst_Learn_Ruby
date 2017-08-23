class Dictionary
  attr_accessor :entries

  def initialize
    @entries ||= {}
  end

  def add(entry = {})
    if entry.is_a?(Hash)
      @entries.merge!(entry)
    else
      @entries[entry] = nil
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(term)
    @entries.keys.include?(term)
  end

  def find(word)
    @entries.select { |key, _value| key.include? word }
  end

  def printable
    @entries.map { |key, value| %Q{[#{key}] "#{value}"} }.sort.join("\n")
  end
end
