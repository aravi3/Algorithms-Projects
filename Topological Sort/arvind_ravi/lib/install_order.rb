# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require_relative 'graph.rb'
require_relative 'topological_sort.rb'

def install_order(arr)
  max = arr.flatten.max
  ids = (1..max).to_a 
  vertices = {}
  
  arr.each do |package|
    vertices[package[0]] = Vertex.new(package[0]) if !vertices[package[0]]
    vertices[package[1]] = Vertex.new(package[1]) if !vertices[package[1]]
    Edge.new(vertices[package[1]], vertices[package[0]])
  end
  
  result = ids.select { |id| vertices[id].nil? }
  result + topological_sort(vertices.values).map { |v| v.value }
end
