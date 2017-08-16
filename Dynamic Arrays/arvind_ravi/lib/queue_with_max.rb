# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_queue = []
  end

  def enqueue(val)
    @store.unshift(val)

    if @max_queue.empty? || val <= max
      @max_queue.unshift(val)
    else
      while !@max_queue.empty?
        @max_queue.pop
      end

      @max_queue.unshift(val)
    end
  end

  def dequeue
    if @store.pop == max
      @max_queue.pop
    end
  end

  def max
    @max_queue.last
  end

  def length
    @store.length
  end
end
