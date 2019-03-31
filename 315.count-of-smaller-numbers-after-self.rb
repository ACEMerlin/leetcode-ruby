# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=315 lang=ruby
#
# [315] Count of Smaller Numbers After Self
#
# https://leetcode.com/problems/count-of-smaller-numbers-after-self/description/
#
# You are given an integer array nums and you have to return a new
# counts array. The counts array has the property where counts[i] is
# the number of smaller elements to the right of nums[i].
#
# Example:
#
# Input: [5,2,6,1]
# Output: [2,1,1,0]
# Explanation:
# To the right of 5 there are 2 smaller elements (2 and 1).
# To the right of 2 there is only 1 smaller element (1).
# To the right of 6 there is 1 smaller element (1).
# To the right of 1 there is 0 smaller element.


# We can convert this problem to range sum query problem, thus using
# Fenwick Tree:
#
#   1. Compress the input by rank, map the input to its rank:
#      [5,2,6,1] => [2,1,3,0], the result'd be the same.
#   2. Iterate compressed input from right to left, given current rank
#      x, update Fenwick Tree at index x by 1 as we've seen the number
#      one more time, the count of elements smaller to the right of x
#      would just be the range sum of Fenwick Tree from 0 to x-1,
#      hence bit.sum(x-1).

# @param {Integer[]} nums
# @return {Integer[]}
def count_smaller(nums)
  rank = {}
  Set.new(nums.sort).each_with_index { |n, i| rank[n] = i }
  bit = BIT.new(rank.size)
  [].tap do |r|
    nums.map { |n| rank[n] }.reverse_each do |i|
      bit.update(i, 1)
      r.unshift bit.sum(i-1)
    end
  end
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
