# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=303 lang=ruby
#
# [303] Range Sum Query - Immutable
#
# https://leetcode.com/problems/range-sum-query-immutable/description/
#
# Given an integer array nums, find the sum of the elements between
# indices i and j (i ≤ j), inclusive.
#
# Example:
#
# Given nums = [-2, 0, 3, -5, 2, -1]
#
# sumRange(0, 2) -> 1
# sumRange(2, 5) -> -1
# sumRange(0, 5) -> -3
#
# Note:
#
# You may assume that the array does not change.
# There are many calls to sumRange function.


# table[i]: the current acumulate sum of [0, i).
# so that: range(i, j) = sum[0, j+1) - sum[0, i)

class NumArray

  def initialize(nums)
    @table = Array.new(nums.count + 1)
    @table[0] = 0
    nums.each_with_index do |n, i|
      @table[i+1] = @table[i] + n
    end
  end

  def sum_range(i, j)
    return @table[j + 1] - @table[i]
  end
end
