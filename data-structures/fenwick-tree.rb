# Fenwick Tree (or Binary Indexed Tree)
#
#   https://www.youtube.com/watch?v=kPaJfAUwViY
#   https://www.topcoder.com/community/competitive-programming/tutorials/binary-indexed-trees/
#   https://cp-algorithms.com/data_structures/fenwick.html

# API is zero-based, implementation is one-based.

class BIT

  def initialize(arg)
    if arg.is_a? Integer
      @size = arg + 1
      @table = Array.new(@size, 0)
    elsif arg.is_a? Array
      @size = arg.size + 1
      @table = Array.new(@size, 0)
      arg.each_with_index { |n, i| update(i, n) }
    end
  end

  def update(i, delta)
    i += 1
    while i < @size
      @table[i] += delta
      i += lowest_one_bit(i)
    end
  end

  def sum(i)
    i += 1
    sum = 0
    while i > 0
      sum += @table[i]
      i -= lowest_one_bit(i)
    end
    sum
  end

  def range_sum(i, j)
    sum(j) - sum(i-1)
  end

  def [](i)
    i += 1
    sum = @table[i]
    z = i - lowest_one_bit(i)
    i -= 1
    until i == z
     sum -= @table[i]
     i -= lowest_one_bit(i)
    end
    sum
  end

  def bsearch(f)
    i, h = 0, highest_one_bit(@size-1)
    while h != 0
      m = i + h
      h >>= 1
      next if m > @size-1
      if f >= @table[m]
        i = m
        f -= @table[m]
      end
    end
    i-1 if f == 0
  end

  def find(f)
    (1...@size).each do |i|
      return i-1 if sum(i) == f
    end
  end

  private

  def highest_one_bit(i)
    i |= (i >>  1);
    i |= (i >>  2);
    i |= (i >>  4);
    i |= (i >>  8);
    i |= (i >> 16);
    return i - (i >> 1);
  end

  def lowest_one_bit(i)
    i & -i
  end
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_bit
    bit = BIT.new(10)
    10.times { |i| assert_equal 0, bit.sum(i) }
    bit.update 0, 2
    bit.update 1, 3
    assert_equal 2, bit.sum(0)
    assert_equal 5, bit.sum(1)
    bit.update 6, 4
    assert_equal 5, bit.bsearch(5)
    assert_equal 7, bit.range_sum(1, 6)
    bit.update 1, 2
    assert_equal 5, bit[1]
    assert_equal 11, bit.sum(8)
  end
end
