# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=209 lang=ruby
#
# [209] Minimum Size Subarray Sum
#
# https://leetcode.com/problems/minimum-size-subarray-sum/description/
#
# Given an array of n positive integers and a positive integer s, find the
# minimal length of a contiguous subarray of which the sum ≥ s. If there isn't
# one, return 0 instead.
#
# Example:
#
# Input: s = 7, nums = [2,3,1,2,4,3]
# Output: 2
# Explanation: the subarray [4,3] has the minimal length under the
# problem constraint.
#
# Follow up:
#
# If you have figured out the O(n) solution, try coding another solution of
# which the time complexity is O(n log n).


# Two Pointers:
#
#   1. window(i, j) is the sum from num[i] to nums[j].
#   2. If window(i, j) >= s, then update minimum count, move i
#      forward, reconsider the new window(i+1, j).
#   3. If window(i, j) < s, then the window is too small, we need more
#      number, move j forward.
#   4. Instead of caculating window(i, j) for every i and j, we can
#      use the technique from prefix sum to calculate window(i, j).

# @param {Integer} s
# @param {Integer[]} nums
# @return {Integer}
def min_sub_array_len(s, nums)
  i = j = 0
  sum, min = 0, Float::INFINITY
  while j < nums.size
    sum += nums[j]              # consider nums[j]
    return 1 if i == j && nums[i] >= s
    if sum < s
      j += 1
    else
      min = [min, j-i+1].min
      sum -= nums[i]            # exclude nums[i]
      sum -= nums[j]            # reconsider nums[j] for the next loop
      i += 1
    end
  end
  min == Float::INFINITY ? 0 : min
end
