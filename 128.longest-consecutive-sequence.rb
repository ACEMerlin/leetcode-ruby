# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=128 lang=ruby
#
# [128] Longest Consecutive Sequence
#
# https://leetcode.com/problems/longest-consecutive-sequence/description/
#
# Given an unsorted array of integers, find the length of the longest
# consecutive elements sequence.
#
# Your algorithm should run in O(n) complexity.
#
# Example:
#
# Input: [100, 4, 200, 1, 3, 2]
# Output: 4
# Explanation: The longest consecutive elements sequence is [1, 2, 3, 4].
# Therefore its length is 4.


# Using Union-Find, the idea is simple.
#
#   1. For each number union all its neighbors's indices.
#   2. Use a hash of { num:index } to quickly check if neighbor exists.
#   3. For number n the neighbors are n-1 and n+1.
#   4. Return the max size of the connected components.

# @param {Integer[]} nums
# @return {Integer}
def longest_consecutive_a(nums)
  return 0 if nums.empty?
  uf = UF.new(nums.length)
  st = {}
  nums.each_with_index do |n, i|
    next if st.has_key?(n)
    st[n] = i
    uf.union(st[n-1], i) if st.has_key?(n-1)
    uf.union(st[n+1], i) if st.has_key?(n+1)
  end
  uf.max_size
end

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


# Using above method we actually can return all the consecutive
# sequences. But since the problem only wants the longest length of
# the sequences, we don't need to use Union-Find to keep track of
# them.

def longest_consecutive(nums)
  return 0 if nums.empty?
  st = Set.new(nums)
  max = 0
  nums.each do |n|
    next if st.include?(n-1)
    succ = n + 1
    succ += 1 while st.include?(succ)
    max = [max, succ-n].max
  end
  max
end
