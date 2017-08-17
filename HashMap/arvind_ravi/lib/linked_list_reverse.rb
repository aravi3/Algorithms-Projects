require_relative 'p04_linked_list'

class LinkedList
  def reverse
    @head, @tail = @tail, @head
    return self
  end
end