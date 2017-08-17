class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    el = @store.pop
    self.class.heapify_down(@store, 0, count)
    el
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, count - 1, count)
  end

  public

  def self.child_indices(len, parent_index)
    children = [(2 * parent_index) + 1, (2 * parent_index) + 2]
    children.select { |child| child < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    parent_idx ||= 0

    while parent_idx < len
      self.child_indices(len, parent_idx).each do |child_idx|
        if prc.call(array[parent_idx], array[child_idx]) == 1
          array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
          break
        end
      end

      parent_idx += 1
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    child_idx ||= len - 1

    while child_idx > 0
      if prc.call(array[self.parent_index(child_idx)], array[child_idx]) == 1
        array[self.parent_index(child_idx)], array[child_idx] = array[child_idx], array[self.parent_index(child_idx)]
      end

      child_idx -= 1
    end

    array
  end
end
