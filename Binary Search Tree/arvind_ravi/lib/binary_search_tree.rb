# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative './bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value, tree_node = @root)
    if !@root
      @root = BSTNode.new(value, nil)
      return
    end

    if value <= tree_node.value
      if tree_node.left
        insert(value, tree_node.left)
      else
        tree_node.left = BSTNode.new(value, tree_node)
      end
    else
      if tree_node.right
        insert(value, tree_node.right)
      else
        tree_node.right = BSTNode.new(value, tree_node)
      end
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value

    if value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    node = find(value)

    if node
      if node.left.nil? && node.right.nil?
        if node.value == @root.value
          @root = nil
        elsif node.value <= node.parent.value
          node.parent.left = nil
        else
          node.parent.right = nil
        end
      elsif node.left.nil? || node.right.nil?
        if node.left
          if node.value <= node.parent.value
            node.parent.left = node.left
            node.left.parent = node.parent
          else
            node.parent.right = node.left
            node.left.parent = node.parent
          end
        else
          if node.value <= node.parent.value
            node.parent.left = node.right
            node.right.parent = node.parent
          else
            node.parent.right = node.right
            node.right.parent = node.parent
          end
        end
      else
        r = maximum(node.left)

        if node.value <= node.parent.value
          node.parent.left = r
          # r.parent = node.parent
        else
          node.parent.right = r
          # r.parent = node.parent
        end

        if r.left
          if r.value <= r.parent.value
            r.parent.left = r.left
            r.left.parent = r.parent
          else
            r.parent.right = r.left
            r.left.parent = r.parent
          end
        end

        r.parent = node.parent
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if !tree_node.right
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil?
    return 0 if !tree_node.left && !tree_node.right
    return 1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil? || (!tree_node.left && !tree_node.right)

    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)

    (left_depth - right_depth).abs <= 1 && is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr)
    arr
  end


  private
  # optional helper methods go here:
end
