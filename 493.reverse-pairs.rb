# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=493 lang=ruby
#
# [493] Reverse Pairs
#
# https://leetcode.com/problems/reverse-pairs/description/
#
# Given an array nums, we call (i, j) an important reverse pair if i < j and
# nums[i] > 2*nums[j].
#
# You need to return the number of important reverse pairs in the given array.
#
# Example1:
#
# Input: [1,3,2,3,1]
# Output: 2
#
# Example2:
#
# Input: [2,4,3,5,1]
# Output: 3
#
# Note: The length of the given array will not exceed 50,000. All the
# numbers in the input array are in the range of 32-bit integer.


# Very similar to problem 315, no doubt we can use Fenwick Tree. But
# the question is what should Fenwick Tree's index associate with.
# Here is the idea:
#
#   1. Sort the input, binary search the number we want and use that
#      as index, this avoids the problem that given x, we can't find
#      y>2x in the input.
#   2. We can scan left to right, at each index i, count numbers left
#      of i which make important reverse pairs, or scan right to left,
#      at each index i, count numbers right of i which make important
#      reverse pairs.

# @param {Integer[]} nums
# @return {Integer}
def reverse_pairs_a(nums)
  r = 0
  sorted = nums.sort
  bit = BIT.new(sorted.size)
  nums.reverse_each do |n|
    r += bit.sum(sorted.bsearch_index { |x| x >= n })
    y = sorted.bsearch_index { |y| y > 2*n }
    bit.update(y, 1) if y
  end
  r
end


# As mentioned in step 1 above, we try to avoid the problem of missing
# target number in the input, so why not just add all missing numbers
# to the input.

def reverse_pairs(nums)
  rank = {}
  Set.new((nums+nums.map { |n| n*2+1 }).sort).each_with_index { |n, i| rank[n] = i }
  bit = BIT.new(rank.size)
  r = 0
  nums.reverse_each do |n|
    r += bit.sum(rank[n])
    bit.update(rank[n*2+1], 1)
  end
  r
end

class BIT

  def initialize(arg)
    @size = arg + 1
    @table = Array.new(@size, 0)
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

  private

  def lowest_one_bit(i)
    i & -i
  end
end
