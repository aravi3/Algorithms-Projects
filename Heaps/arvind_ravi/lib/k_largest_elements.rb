require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
  array.heap_sort!.reverse!
  result = []
  idx = 0

  while result.length != k
    result.push(array[idx])
    idx += 1
  end

  result
end

p k_largest_elements([2, 3, 4, 6, -1, 4], 3)
