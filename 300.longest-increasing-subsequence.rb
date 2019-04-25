# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=300 lang=ruby
#
# [300] Longest Increasing Subsequence
#
# https://leetcode.com/problems/longest-increasing-subsequence/description/
#
# Given an unsorted array of integers, find the length of longest
# increasing subsequence.
#
# Example:
#
# Input: [10,9,2,5,3,7,101,18]
# Output: 4
# Explanation: The longest increasing subsequence is [2,3,7,101], therefore the
# length is 4.
#
# Note:
#
# There may be more than one LIS combination, it is only necessary for you to
# return the length.
# Your algorithm should run in O(n2) complexity.
#
# Follow up: Could you improve it to O(n log n) time complexity?


# O(n^2)

# @param {Integer[]} nums
# @return {Integer}
def length_of_lis(nums)
  return 0 if nums.empty?
  n = nums.size
  d = Array.new(n, 1)
  (1..n-1).each do |i|
    (0..i-1).each do |j|
      if nums[j] < nums[i] && d[i] < d[j]+1
        d[i] = d[j]+1
      end
    end
  end
  d.max
end

def list_of_lis(nums)
  return 0 if nums.empty?
  n = nums.size
  d, p = Array.new(n, 1), Array.new(n, -1)
  (1..n-1).each do |i|
    (0..i-1).each do |j|
      if nums[j] < nums[i] && d[i] < d[j]+1
        d[i] = d[j] + 1
        p[i] = j
      end
    end
  end
  pos, ans = d.index(d.max), []
  while pos != -1
    ans.unshift(nums[pos])
    pos = p[pos]
  end
  ans
end


# O(n^2)

def length_of_lis(nums)
  return 0 if nums.empty?
  n = nums.size
  d = Array.new(n+1, Float::INFINITY)
  d[0] = -Float::INFINITY
  (0..n-1).each do |i|
    (1..n).each do |j|
      if d[j-1] < nums[i] && nums[i] < d[j]
        d[j] = nums[i]
      end
    end
  end
  ans = 0
  (0..n).each do |i|
    ans = i if d[i] < Float::INFINITY
  end
  ans
end


# O(n*logn)

def length_of_lis(nums)
  return 0 if nums.empty?
  n = nums.size
  d = Array.new(n+1, Float::INFINITY)
  d[0] = -Float::INFINITY
  (0..n-1).each do |i|
    j = d.bsearch_index { |x| x > nums[i] }
    if d[j-1] < nums[i] && nums[i] < d[j]
      d[j] = nums[i]
    end
  end
  ans = 0
  (0..n).each do |i|
    ans = i if d[i] < Float::INFINITY
  end
  ans
end

def list_of_lis(nums)
  return 0 if nums.empty?
  n = nums.size
  d, p = Array.new(n+1, Float::INFINITY), Array.new(n, -1)
  d[0] = -Float::INFINITY
  (0..n-1).each do |i|
    j = d.bsearch_index { |x| x > nums[i] }
    if d[j-1] < nums[i] && nums[i] < d[j]
      d[j] = nums[i]
      p[i] = j
    end
  end
  ans = 0
  (0..n).each do |i|
    ans = i if d[i] < Float::INFINITY
  end
  ans
end


# O(n*logn)

def length_of_lis(nums)
  ans = []
  nums.each do |n|
    if ans.empty?  || n > ans[-1]
      ans << n
    else
      i = ans.bsearch_index { |x| x >= n }
      ans[i] = n
    end
  end
  ans.size
end

def list_of_lis(nums)
  d, p = [], Array.new(nums.size, -1)
  nums.each_with_index do |n, i|
    if d.empty?  || n > d[-1][0]
      p[i] = i > 0 ? d[d.size-1][1] : -1
      d << [n, i]
    else
      j = d.bsearch_index { |(x, _)| x >= n }
      d[j] = [n, i]
      p[i] = j > 0 ? d[j-1][1] : -1
    end
  end
  ans, pos = [], d[-1][1]
  while pos != -1
    ans.unshift(nums[pos])
    pos = p[pos]
  end
  ans
end


# Segment Tree. O(n*log(n)).

def length_of_lis(nums)
  n = nums.size
  t = SegTree.new(Array.new(n, 0))
  a = nums.zip(n.times).sort_by { |(a, b)| [a, -b] }
  a.each do |(_, j)|
    if j == 0
      t.update(0, 1)
    else
      t.update(j, t.query(0, j-1)+1)
    end
  end
  t.query(0, n-1)
end

class SegTree

  def combine(l, r)
    [l, r].max
  end

  def update(p, v, i=1, lo=0, hi=@size-1)
    if lo == hi
      @tree[i] = v
    else
      m = lo+(hi-lo)/2
      if p <= m
        update(p, v, i*2, lo, m)
      else
        update(p, v, i*2+1, m+1, hi)
      end
      @tree[i] = combine(@tree[i*2], @tree[i*2+1])
    end
  end

  def query(p, q, i=1, lo=0, hi=@size-1)
    return @tree[i] if lo == p && hi == q
    m = lo+(hi-lo)/2
    return query(p, q, i*2, lo, m) if q <= m
    return query(p, q, i*2+1, m+1, hi) if p > m
    l = query(p, m, i*2, lo, m)
    r = query(m+1, q, i*2+1, m+1, hi)
    combine(l, r)
  end

  def build(a, i, lo, hi)
    return if lo > hi
    if lo == hi
      @tree[i] = a[lo]
    else
      m = lo+(hi-lo)/2
      build(a, i*2, lo, m)
      build(a, i*2+1, m+1, hi)
      @tree[i] = combine(@tree[i*2], @tree[i*2+1])
    end
  end

  def initialize(a)
    @size = a.size
    @tree = Array.new(tree_size(@size))
    build(a, 1, 0, @size-1)
  end

  def tree_size(n)
    s = 1
    s <<= 1 while s < n
    s << 1
  end
end
