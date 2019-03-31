# Sparse Table
#
#   https://cp-algorithms.com/data_structures/sparse-table.html
#   https://www.youtube.com/watch?v=EKcQt-74bNw

class SparseTable

  def top(a, b)
    len = b-a+1
    k = log2_floor(len)
    m = b-(1<<k)+1
    compare(@table[k][a], @table[k][m])
  end

  attr_accessor :table

  private

  def initialize(arr, &block)
    @n = arr.size
    @fn = block
    @maxk = log2_floor(@n)
    @table = Array.new(@maxk+1) { Array.new(@n) }
    @n.times { |i| @table[0][i] = arr[i] }
    (1..@maxk).each do |k|
      @n.times do |i|
        j = i+(1<<(k-1))
        @table[k][i] = compare(@table[k-1][i],
                               @table[k-1][j]) if j < @n
      end
    end
  end

  def compare(a, b)
    if a.nil?
      b
    elsif b.nil?
      a
    else
      @fn[a, b] ? a : b
    end
  end

  def log2_floor(i)
    Math.log2(i).to_i
  end
end

class RangeMinQuery < SparseTable

  def initialize(arr)
    super(arr) { |x, y| (x <=> y) == -1 }
  end

  alias_method :min, :top
end

class RangeMaxQuery < SparseTable

  def initialize(arr)
    super(arr) { |x, y| (x <=> y) == 1 }
  end

  alias_method :max, :top
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_range_min_query
    st = RangeMinQuery.new([14, 11, 16, 8, 12, 5, 9, 12])
    assert_equal 5, st.min(0, 7)
    assert_equal 8, st.min(1, 4)
    assert_equal 5, st.min(2, 5)
    assert_equal 14, st.min(0, 0)
    assert_equal 11, st.min(1, 1)
    assert_equal 16, st.min(2, 2)
    assert_equal 8, st.min(3, 3)
    assert_equal 12, st.min(4, 4)
    assert_equal 5, st.min(5, 5)
  end
end
