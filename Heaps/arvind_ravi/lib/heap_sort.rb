require_relative "heap"

class Array
  def heap_sort!
    return self if self.length <= 1

    0.upto(self.length - 1) do |idx|
      BinaryMinHeap.heapify_up(self, idx, self.length)
    end

    (self.length - 1).downto(0) do |idx|
      self[0], self[idx] = self[idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, idx)
    end

    # index = 1
    # len = self.length
    # BinaryMinHeap.heapify_down(self, 1, len)
    # # # p self
    # # #
    # while index < len
    #   self[len - 1], self[index] = self[index], self[len - 1]
    #   index += 1
    #   len -= 1
    #   BinaryMinHeap.heapify_down(self, index, len)
    # end
    # #
    self.reverse!
  end
end
