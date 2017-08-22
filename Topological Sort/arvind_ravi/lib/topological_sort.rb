require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  result = []
  wait = []
  
  vertices.each do |vertex|
    wait.push(vertex) if vertex.in_edges.empty?
  end
  
  while !wait.empty?
    current_vertex = wait.shift 
    result.push(current_vertex)
    
    while !current_vertex.out_edges.empty?
      edge = current_vertex.out_edges.pop
      wait.push(edge.to_vertex) if edge.to_vertex.in_edges.length == 1
      edge.destroy!
    end
  end
  
  result.length == vertices.length ? result : []
end
