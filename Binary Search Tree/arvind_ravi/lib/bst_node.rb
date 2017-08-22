class BSTNode
  attr_accessor :left, :right, :parent
  attr_reader :value
  
  def initialize(value, parent)
    @parent = parent
    @value = value
    @left = nil
    @right = nil
  end
end
