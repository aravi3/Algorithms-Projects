require_relative "heap"

class Array
  def heap_sort!
    return self if self.length <= 1
    
    len = self.length
    BinaryMinHeap.heapify_up(self, len - 1, len)
    
    while len > 0
      self[len - 1], self[0] = self[0], self[len - 1]
      len -= 1
      BinaryMinHeap.heapify_up(self, len - 1, len)
    end
    
    self.reverse!
  end
end
