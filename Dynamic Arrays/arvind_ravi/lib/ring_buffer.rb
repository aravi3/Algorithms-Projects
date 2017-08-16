require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(@length)
    @index = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index > @length - 1
    @store[check_index(index)]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' if index > @length - 1
    @store[check_index(index)] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length.zero?
    val = @store[check_index(@length - 1)]
    @length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[check_index(@length)] = val
    @length += 1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length.zero?
    @length -= 1
    val = @store[check_index(0)]
    @index += 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @index = @index.zero? ? @capacity - 1 : @index - 1
    @store[@index] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (@index + index) % @capacity
  end

  def resize!
    new_store = StaticArray.new(@length * 2)
    
    (0...@length).each do |idx|
      new_store[idx] = @store[check_index(idx)]
    end
    
    @capacity *= 2
    @index = 0
    @store = new_store
  end
end