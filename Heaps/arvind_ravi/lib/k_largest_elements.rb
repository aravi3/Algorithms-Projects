require_relative 'heap'

def k_largest_elements(array, k)
  result = []

  len = array.length
  BinaryMinHeap.heapify_up(array, len - 1, len)

  while result.length != k
    array[len - 1], array[0] = array[0], array[len - 1]
    result.push(array[len - 1])
    len -= 1
    BinaryMinHeap.heapify_up(array, len - 1, len)
  end

  result
end

p k_largest_elements([2, 3, 4, 6, -1, 4], 4)
