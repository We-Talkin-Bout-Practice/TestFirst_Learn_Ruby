def echo(say)
  say
end

def shout(say)
  say.upcase
end

def repeat(say, times = 2)
  ("#{say} " * times).strip
end

def start_of_word(word, num)
  word[0..(num - 1)]
end

def first_word(sentence)
  sentence.split.first
end

def titleize(sentence)

  words = sentence.split.map do |word|
    if %w(the and over).include?(word)
      word
    else
      word.capitalize
    end
  end
  words.first.capitalize!
  words.join(' ')
end
