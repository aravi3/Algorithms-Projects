class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    num = 0

    self.each_with_index do |el, idx|
      num += el * (idx + 4)
    end

    num
  end
end

class String
  def hash
    num = 0

    self.chars.each_with_index do |el, idx|
      num += el.ord * (idx + 4)
    end

    num
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    answer = 0

    self.each do |k,v|
      answer += k.hash + v.hash
    end
    
    answer
  end
end
