# Priority Queue
#
# See Algoritms Part 1 from Princeton University:
#   https://www.coursera.org/learn/algorithms-part1/lecture/Uzwy6/binary-heaps
#
# See MinHeap and MaxHeap down below to see how to use PQueue.

class PQueue

  def initialize(array=[], &block)
    @fn = block || ->(x, y) { (x <=> y) == 1}
    @arr = [nil]
    return if array.empty?
    if array[0].is_a? Array
      @arr.concat(array.map { |k, v| Node.new(k, v) })
    else
      @arr.concat(array.map { |k| Node.new(k) })
    end
    (array.size/2).downto(1).each { |i| sink(i) }
  end

  def push(k, v=k)
    @arr << Node.new(k, v)
    swim(size)
  end
  alias_method :<<, :push

  def pop
    x = @arr[1]
    @arr[1] = @arr[-1]
    @arr.pop
    sink(1)
    x&.val
  end

  def top
    @arr[1]&.val
  end

  def size
    @arr.length - 1
  end

  def empty?
    size == 0
  end

  private

  class PQueue::Node
    attr_accessor :key, :val
    def initialize(key, val=key)
      @key, @val = key, val
    end
  end

  def sink(i)
    until lchild(i) > size
      j = lchild(i)
      j += 1 if j+1 <= size && @fn[@arr[j+1].key, @arr[j].key]
      break if @fn[@arr[i].key, @arr[j].key]
      swap(i, j)
      i = j
    end
  end

  def swim(i)
    while i > 1 && @fn[@arr[i].key, @arr[parent(i)].key]
      swap(i, parent(i))
      i = parent(i)
    end
  end

  def parent(i)
    i/2
  end

  def lchild(i)
    i*2
  end

  def rchild(i)
    i*2+1
  end

  def swap(i, j)
    @arr[i], @arr[j] = @arr[j], @arr[i]
  end
end

class MinHeap < PQueue
  def initialize(array=[])
    super(array) { |x, y| (x <=> y) == -1 }
  end

  alias_method :min, :top
end

class MaxHeap < PQueue
  def initialize(array=[])
    super(array) { |x, y| (x <=> y) == 1 }
  end

  alias_method :max, :top
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_min_heap
    minHeap = MinHeap.new([2,1,3,6,8,2,8,0])
    assert_equal minHeap.min, 0
    minHeap.pop
    minHeap.pop
    assert_equal minHeap.min, 2
    minHeap << 0
    assert_equal minHeap.min, 0
    10.times { minHeap.pop }
    assert minHeap.min.nil?
    assert_equal minHeap.size, 0
    minHeap.push(1, :fish)
    minHeap.push(2, :cat)
    minHeap.push(0, :ha)
    assert_equal minHeap.min, :ha
  end

  def test_max_heap
    maxHeap = MaxHeap.new([2,1,3,6,8,2,8,0])
    assert_equal maxHeap.max, 8
    maxHeap.pop
    maxHeap.pop
    assert_equal maxHeap.max, 6
    maxHeap << 9
    assert_equal maxHeap.max, 9
    10.times { maxHeap.pop }
    assert maxHeap.max.nil?
    assert_equal maxHeap.size, 0
    maxHeap.push(1, :fish)
    maxHeap.push(2, :cat)
    maxHeap.push(0, :ha)
    assert_equal maxHeap.max, :cat
  end
end
