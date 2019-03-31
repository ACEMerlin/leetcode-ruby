# Union Find (weighed quick-union with path compression)
#
# See Algoritms Part 1 from Princeton University:
#   https://www.coursera.org/learn/algorithms-part1/lecture/ZgecU/quick-union

class UF
  def initialize(size)
    @arr = Array.new(size, &:itself)
    @weight = Array.new(size, 1)
  end

  def connected?(p, q)
    root(p) == root(q)
  end

  def root(p)
    until p == @arr[p]
      @arr[p] = @arr[@arr[p]]
      p = @arr[p]
    end
    p
  end

  def union(p, q)
    i, j = root(p), root(q)
    return if i == j
    if @weight[i] < @weight[j]
      @arr[i] = j
      @weight[j] += @weight[i]
    else
      @arr[j] = i
      @weight[i] += @weight[j]
    end
  end

  def max_size
    @weight.max
  end
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_union_find
    uf = UF.new(10)
    assert !uf.connected?(0, 6)
    uf.union(0, 6)
    assert uf.connected?(0, 6)
    uf.union(1, 2)
    uf.union(1, 0)
    uf.union(6, 7)
    assert_equal uf.root(2), uf.root(7)
  end
end
