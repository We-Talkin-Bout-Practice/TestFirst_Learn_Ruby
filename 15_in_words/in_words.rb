require 'pry'

class Fixnum
  SINGLES = %w(zero one two three four five six seven eight nine)

  TEENS   = %w(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)

  DOUBLES = {
    1 => 'ten',
    2 => 'twenty',
    3 => 'thirty',
    4 => 'forty',
    5 => 'fifty',
    6 => 'sixty',
    7 => 'seventy',
    8 => 'eighty',
    9 => 'ninety'
  }

  HIGH = %w(thousand million billion trillion)

  def in_words
    arr    = self.to_s.split(//).map(&:to_i)
    length = arr.size

    return singles_in_words        if length == 1
    return teens_in_words          if length == 2 && self <= 19
    return doubles_in_words(arr)   if length == 2 && self >= 20
    return hundred_in_words(arr)   if length == 3
    return thousands_in_words(arr) if length <= 6
    return millions_in_words(arr)  if length <= 9
    return billions_in_words(arr)  if length <= 12
    return trillions_in_words(arr) if length <= 15
  end

  def singles_in_words(idx = self, hide_zero: false)
    return nil if hide_zero && idx.zero?
    SINGLES[idx]
  end

  def teens_in_words(idx = (self % 10))
    TEENS[idx]
  end

  def doubles_in_words(arr)
    tens   = arr[0]
    single = arr[1]

    if single == 0
      DOUBLES[tens]
    else
      "#{DOUBLES[tens]} #{SINGLES[single]}"
    end
  end

  def hundred_in_words(arr)
    return nil if arr.all?(&:zero?)
    return singles_in_words(arr[0]) if arr.length == 1

    hundy   = arr[0]
    singles = arr[2]
    dub_arr = arr[1..2]

    doubles =
      if dub_arr.all?(&:zero?)
        nil
      elsif dub_arr.join.to_i < 20
        teens_in_words(singles)
      else
        doubles_in_words(dub_arr)
      end

    "#{singles_in_words(hundy)} hundred #{doubles}".strip
  end

  def thousands_in_words(arr, length = arr.length)
    if length == 6
      thousands = hundred_in_words(arr[0..2])
      dub_arr   = arr[3..-1]
    elsif length == 5
      thousands = doubles_in_words(arr[0..1])
      dub_arr   = arr[2..-1]
    else
      thousands = singles_in_words(arr[0])
      dub_arr   = arr[1..-1]
    end

    hundies =
      if dub_arr.all?(&:zero?)
        nil
      else
        hundred_in_words(dub_arr)
      end

    "#{thousands} thousand #{hundies}".strip
  end

  def millions_in_words(arr)
    millions_arr = arr[0..-7]

    millions =
      if millions_arr.length == 3
        hundred_in_words(millions_arr)
      else
        doubles_in_words(millions_arr)
      end

    remainder = arr[-6..-1].join.to_i.to_s.split(//).map(&:to_i)

    thousands =
      if remainder.length == 1
        singles_in_words(remainder[0])
      else
        thousands_in_words(arr[-6..-1])
      end

    "#{millions} million #{thousands}".strip
  end

  def billions_in_words(arr)
    billions_arr = arr[0..-10]
    billions     = chose_parser(billions_arr)
    remainder    = arr[-9..-1].join.to_i.to_s.split(//).map(&:to_i)

    millions =
      if remainder.length == 1
        singles_in_words(remainder[0])
      else
        millions_in_words(arr[-9..-1])
      end

    "#{billions} billion #{millions}".strip
  end

  def trillions_in_words(arr)
    hundreds_arr  = filter_leading_zero(arr[-3..-1])
    thousands_arr = filter_leading_zero(arr[-6..-4])
    millions_arr  = filter_leading_zero(arr[-9..-7])
    billions_arr  = filter_leading_zero(arr[-12..-10])
    trillions_arr = arr[0..-13]

    hundreds  = chose_parser(hundreds_arr)
    thousands = chose_parser(thousands_arr)
    millions  = chose_parser(millions_arr)
    billions  = chose_parser(billions_arr)
    trillions = chose_parser(trillions_arr)

    [
      ("#{trillions} trillion " if trillions),
      ("#{billions} billion "   if billions),
      ("#{millions} million "   if millions),
      ("#{thousands} thousand " if thousands),
      ("#{hundreds}"   if hundreds)
    ].join('').strip
  end

  def filter_leading_zero(arr)
    arr.join.to_i.to_s.split(//).map(&:to_i)
  end

  def chose_parser(arr)
    if arr.length == 3
      hundred_in_words(arr)
    elsif arr.length == 2 && arr.join.to_i < 20
      teens_in_words(arr)
    elsif arr.length == 2
      doubles_in_words(arr)
    else
      singles_in_words(arr[0], hide_zero: true)
    end
  end
end
