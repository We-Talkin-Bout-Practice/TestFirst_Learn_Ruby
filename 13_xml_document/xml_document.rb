class XmlDocument
  def initialize(indent = false)
    @indent = indent
    @indent_level = 0
  end

  def method_missing(method_name, *args, &block)
    attributes = args[0] || {}

    result  = ""
    result += ("  " * @indent_level) if @indent
    result += "<#{method_name}"

    attributes.each_pair do |key, value|
      result += " #{key}='#{value}'"
    end

    if block
      result += ">"
      result += "\n" if @indent

      @indent_level += 1
      result += yield
      @indent_level -= 1

      result += ("  " * @indent_level) if @indent
      result += "</#{method_name}>"
      result += "\n" if @indent
    else
      result += "/>"
      result += "\n" if @indent
    end

    result
  end
end
