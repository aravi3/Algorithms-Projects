require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      @count += 1
      bucket(key).append(key, val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    return nil if !include?(key)
    @count -= 1
    bucket(key).remove(key)
  end

  def each(&blk)
    @store.each do |linked_list|
      linked_list.each do |node|
        blk.call([node.key, node.val])
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_store.flatten.each do |linked_list|
      linked_list.each do |node|
        bucket(node.key).append(node.key, node.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
