require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  # !string.chars.to_a.permutation.map(&:join).select { |word| word == word.reverse }.empty?
  hash = HashMap.new

  string.chars.each do |ch|
    if hash.include?(ch)
      hash.delete(ch)
    else
      hash.set(ch, 0)
    end
  end

  return true if hash.count == 1
  false
end
