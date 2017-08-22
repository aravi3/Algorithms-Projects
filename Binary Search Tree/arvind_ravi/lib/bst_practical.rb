require_relative './binary_search_tree'

def kth_largest(tree_node, k)
  arr = []
  reverse_order_traversal(tree_node, arr, k)
  arr[k - 1]
end

def reverse_order_traversal(tree_node, arr, k)
  return if tree_node.nil?
  reverse_order_traversal(tree_node.right, arr, k)
  arr.push(tree_node)
  reverse_order_traversal(tree_node.left, arr, k)
  return arr if arr.length == k
end
