# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=84 lang=ruby
#
# [84] Largest Rectangle in Histogram
#
# https://leetcode.com/problems/largest-rectangle-in-histogram/description/
#
# Given n non-negative integers representing the histogram's bar
# height where the width of each bar is 1, find the area of largest
# rectangle in the histogram.
#
# Above is a histogram where width of each bar is 1, given height =
# [2,1,5,6,2,3].
#
# The largest rectangle is shown in the shaded area, which has area =
# 10 unit.
#
# Example:
#
# Input: [2,1,5,6,2,3]
# Output: 10


# See:
#
#   - http://www.informatik.uni-ulm.de/acm/Locals/2003/html/judge.html


# O(n^3).
#
# Given column i and j, the height of the rectangle area between these
# two column is the minimum height of the column between i and j, and
# the width is j-i+1.

# @param {Integer[]} heights
# @return {Integer}
def largest_rectangle_area(heights)
  n, ans = heights.size, -Float::INFINITY
  (0..n-1).each do |i|
    (i..n-1).each do |j|
      ans = [ans, heights[i..j].min*(j-i+1)].max
    end
  end
  ans
end


# O(n^2).
#
# Reuse the minimum height from previous comparison.

def largest_rectangle_area(heights)
  n, ans = heights.size, -Float::INFINITY
  (0..n-1).each do |i|
    min = heights[i]
    (i..n-1).each do |j|
      min = [min, heights[j]].min
      ans = [ans, min*(j-i+1)].max
    end
  end
  ans
end


# O(n*log(n)) using Sparse Table.

def largest_rectangle_area(heights)
  return 0 if heights.empty?
  largest(MinSpTable.new(heights), 0, heights.size-1)
end

def largest(t, lo, hi)
  return -Float::INFINITY if lo > hi
  n, k = t.min(lo, hi)
  [n*(hi-lo+1), largest(t, lo, k-1), largest(t, k+1, hi)].max
end

class MinSpTable

  def initialize(arr)
    n = arr.size
    maxk = log2_floor(n)
    @table = Array.new(maxk+1) { Array.new(n) }
    n.times { |i| @table[0][i] = [arr[i], i] }
    (1..maxk).each do |k|
      n.times do |i|
        j = i+(1<<(k-1))
        @table[k][i] = [@table[k-1][i], @table[k-1][j]].compact.min_by(&:first)
      end
    end
  end

  def log2_floor(n)
    Math.log2(n).to_i
  end

  def min(a, b)
    k = log2_floor(b-a+1)
    m = b-(1<<k)+1
    [@table[k][a], @table[k][m]].min_by(&:first)
  end
end


# O(n*log(n)) using Segment Tree.

def largest_rectangle_area(heights)
  return 0 if heights.empty?
  largest(MinSegTree.new(heights), 0, heights.size-1)
end

def largest(t, lo, hi)
  return -Float::INFINITY if lo > hi
  n, k = t.min(lo, hi)
  [n*(hi-lo+1), largest(t, lo, k-1), largest(t, k+1, hi)].max
end

class MinSegTree

  def initialize(arr)
    @size = arr.size
    @tree = Array.new(tree_size(@size))
    build(arr, 1, 0, @size-1)
  end

  def build(arr, i, lo, hi)
    if lo == hi
      @tree[i] = [arr[lo], lo]
    else
      m = (lo+hi)/2
      build(arr, i*2, lo, m)
      build(arr, i*2+1, m+1, hi)
      @tree[i] = combine(@tree[i*2], @tree[i*2+1])
    end
  end

  def tree_size(n)
    s = 1
    s <<= 1 while s < n
    s << 1
  end

  def combine(l, r)
    l[0] < r[0] ? l : r
  end

  def min(p, q, i=1, lo=0, hi=@size-1)
    return @tree[i] if lo == p && hi == q
    m = (lo+hi)/2
    return min(p, q, i*2, lo, m) if q <= m
    return min(p, q, i*2+1, m+1, hi) if p > m
    l = min(p, m, i*2, lo, m)
    r = min(m+1, q, i*2+1, m+1, hi)
    combine(l, r)
  end
end


# O(n) using Stack.

def largest_rectangle_area(heights)
  heights << 0
  q, ans = [], 0
  (0..heights.size-1).each do |i|
    while !q.empty? && heights[q[-1]] > heights[i]
      ans = [heights[q.pop]*(q.empty? ? i : (i-q[-1]-1)), ans].max
    end
    q << i
  end
  ans
end
