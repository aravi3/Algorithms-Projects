class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next, @next.prev = @next, @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail && @tail.prev == @head
    false
  end

  def get(key)
    self.each do |node|
      return node.val if key == node.key
    end
  end

  def include?(key)
    self.each do |node|
      return true if key == node.key
    end

    false
  end

  def append(key, val)
    if include?(key)
      update(key, val)
    else
      node = Node.new(key, val)
      previous = @tail.prev
      @tail.prev = node
      previous.next = node
      node.prev = previous
      node.next = @tail
      return node
    end
  end

  def update(key, val)
    self.each do |node|
      node.val = val if key == node.key
    end
  end

  def remove(key)
    self.each do |node|
      if key == node.key
        node.remove
        break
      end
    end
  end

  def each(&blk)
    node = @head

    while node.next.next
      node = node.next
      blk.call(node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
