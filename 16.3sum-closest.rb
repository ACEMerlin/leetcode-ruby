# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=16 lang=ruby
#
# [16] 3Sum Closest
#
# https://leetcode.com/problems/3sum-closest/description/
#
# Given an array nums of n integers and an integer target, find three
# integers in nums such that the sum is closest to target. Return the
# sum of the three integers. You may assume that each input would have
# exactly one solution.
#
# Example:
#
# Given array nums = [-1, 2, 1, -4], and target = 1.
#
# The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).


# See problem 15.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def three_sum_closest(nums, target)
  nums.sort!
  n, min = nums.size, Float::INFINITY
  (0...n).each do |i|
    j = i+1
    k = n-1
    while j < k
      diff = nums[i] + nums[j] + nums[k] - target
      if diff < 0
        j += 1
      elsif diff > 0
        k -= 1
      else
        return diff + target
      end
      min = diff if diff.abs < min.abs
    end
  end
  min + target
end
