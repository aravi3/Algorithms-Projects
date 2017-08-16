require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(@length)
    @capacity = 8
  end

  # O(1)
  def [](index)
    if !check_index(index)
      raise "index out of bounds"
    end
    
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    end
    
    last = @store[-1]
    @store = @store[0..-2]
    @length -= 1
    last
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise "index out of bounds"
    end
    
    new_store = StaticArray.new(@length)
    (0...@length - 1).each do |idx|
      new_store[idx] = @store[idx + 1]
    end
    
    
    first = @store[0]
    @store = new_store
    @length -= 1
    first
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    
    new_store = StaticArray.new(@length)
    (0...@length).each do |idx|
      new_store[idx + 1] = @store[idx]
    end
    
    new_store[0] = val
    @store = new_store
    
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    @store[index]
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_store = StaticArray.new(@length * 2)
    
    (0...@length).each do |idx|
      new_store[idx] = @store[idx]
    end
    
    @capacity *= 2
    @store = new_store
  end
end
