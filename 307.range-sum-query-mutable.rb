# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=307 lang=ruby
#
# [307] Range Sum Query - Mutable
#
# https://leetcode.com/problems/range-sum-query-mutable/description/
#
# Given an integer array nums, find the sum of the elements between
# indices i and j (i ≤ j), inclusive.
#
# The update(i, val) function modifies nums by updating the element at
# index i to val.
#
# Example:
#
# Given nums = [1, 3, 5]
#
# sumRange(0, 2) -> 9
# update(1, 2)
# sumRange(0, 2) -> 8
#
# Note: The array is only modifiable by the update function. You may
# assume the number of calls to update and sumRange function is
# distributed evenly.


# Fenwick Tree, see data-structures/fenwick-tree.rb

class NumArray

  def initialize(nums)
    @bit = BIT.new(nums.size)
    nums.each_with_index { |n, i| @bit.update(i+1, n) }
  end

  def update(i, val)
    @bit.update(i+1, val-@bit[i+1])
  end

  def sum_range(i, j)
    @bit.range_sum(i+1, j+1)
  end
end

class BIT

  def initialize(size)
    @size = size + 1
    @table = Array.new(@size, 0)
  end

  def update(i, delta)
    while i < @size
      @table[i] += delta
      i += lowest_one_bit(i)
    end
  end

  def sum(i)
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
    i if f == 0
  end

  def find(f)
    (1...@size).each do |i|
      return i if sum(i) == f
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


# Segment Tree, see data-structures/segment-tree.rb

class NumArray2

  def initialize(nums)
    @st = SegmentTree.new(nums)
  end

  def update(i, val)
    @st.update(i, val)
  end

  def sum_range(i, j)
    @st.sum(i, j)
  end
end

class SegmentTree

  def initialize(arr)
    @size = arr.size
    @arr = arr
    @table = Array.new(tree_size(@size), 0)
    build(1, 0, [@size-1, 0].max )
  end

  def sum(a, b)
    sum_(1, 0, @size-1, a, b)
  end

  def update(p, val)
    update_(1, 0, @size-1, p, val)
  end

  private

  def build(i, a, b)
    if a == b
      @table[i] = @arr[a]
    else
      m = (a+b)/2
      build(i*2, a, m)
      build(i*2+1, m+1, b)
      @table[i] = @table[i*2] + @table[i*2+1]
    end
  end

  def sum_(i, lo, hi, a, b)
    return 0 if a > b
    return @table[i] if lo == a && hi == b
    m = (lo+hi)/2
    sum_(i*2, lo, m, a, [b, m].min) + sum_(i*2+1, m+1, hi, [a, m+1].max, b)
  end

  def update_(i, lo, hi, p, val)
    if lo == hi
      @table[i] = val
    else
      m = (lo+hi)/2
      if p <= m
        update_(i*2, lo, m, p, val)
      else
        update_(i*2+1, m+1, hi, p, val)
      end
      @table[i] = @table[i*2] + @table[i*2+1]
    end
  end

  def tree_size(n)
    s = 1
    s <<=1 while s < n
    s << 1
  end
end
