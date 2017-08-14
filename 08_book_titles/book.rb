class Book
  attr_reader :title

  WORD_PARTICLES = %w{a an and the in of}

  def title=(new_title)
    words = new_title.capitalize.split(" ")

    result = words.map do |word|
      if WORD_PARTICLES.include? word
        word
      else
        word.capitalize
      end
    end

    @title = result.join(" ")
  end
end
