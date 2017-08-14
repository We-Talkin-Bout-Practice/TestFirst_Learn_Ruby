VOWELS = %w{ a e i o u qu }

def translate(word)
  letters = word.split.map do |letter|
    i = 0
    while not vowel?(letter[i, 1])
      if (letter[i,2] == 'qu')
        i += 2
      else
        i += 1
      end
    end

    "#{letter[i..-1]}#{letter[0, i]}ay"
  end

  letters.join(' ')
end

def vowel?(letter)
  VOWELS.include?(letter)
end
