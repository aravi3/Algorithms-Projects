require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = map[key]
      update_node!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + map.to_s + '\n' + 'Store: ' + store.to_s
  end

  private
  attr_reader :store, :map

  def calc!(key)
    val = @prc.call(key)
    new_node = @store.append(key, val)
    map[key] = new_node
    eject! if count > @max
    val
  end

  def update_node!(node)
    @store.remove(node.key)
    @store.append(node.key, node.val)
  end

  def eject!
    first_node_key = @store.first.key
    @map.delete(first_node_key)
    @store.remove(first_node_key)
    nil
  end
end
