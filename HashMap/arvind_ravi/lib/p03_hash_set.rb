# require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    resize! if @count == num_buckets
    return true if include?(key)
    @count += 1
    self[num].push(key)
  end

  def include?(key)
    num = key.hash
    self[num].include?(key)
  end

  def remove(key)
    num = key.hash
    return false if !include?(key)
    self[num].delete_at(self[num].index(key))
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.each { |key| insert(key) }
  end
end
