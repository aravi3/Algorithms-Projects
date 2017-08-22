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

    while parent_idx < (len - 1)
      count = 0

      children = self.child_indices(len, parent_idx)
      break if children[0].nil? && children[1].nil?

      if children[1]
        smallest = prc.call(array[children[0]], array[children[1]]) == -1 ? children[0] : children[1]
      else
        smallest = children[0]
      end

      if prc.call(array[parent_idx], array[smallest]) == 1
        count += 1
        array[parent_idx], array[smallest] = array[smallest], array[parent_idx]
        parent_idx = smallest
      end

      # self.child_indices(len, parent_idx).each do |child_idx|
      #   if prc.call(array[parent_idx], array[child_idx]) == 1
      #     count += 1
      #     array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      #     parent_idx = child_idx
      #     break
      #   end
      # end

      break if count == 0
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    child_idx ||= len - 1

    while child_idx > 0
      if prc.call(array[self.parent_index(child_idx)], array[child_idx]) == 1
        array[self.parent_index(child_idx)], array[child_idx] = array[child_idx], array[self.parent_index(child_idx)]
        child_idx = self.parent_index(child_idx)
      else
        break
      end
    end

    array
  end
end
