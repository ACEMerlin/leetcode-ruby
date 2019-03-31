# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=15 lang=ruby
#
# [15] 3Sum
#
# https://leetcode.com/problems/3sum/description/
#
# Given an array nums of n integers, are there elements a, b, c in
# nums such that a + b + c = 0? Find all unique triplets in the array
# which gives the sum of zero.
#
# Note: The solution set must not contain duplicate triplets.
#
# Example:
#
# Given array nums = [-1, 0, 1, 2, -1, -4],
#
# A solution set is:
# [
# ⁠ [-1, 0, 1],
# ⁠ [-1, -1, 2]
# ]


# It's best to use two pointers.
#
# We sort the nums first so that all duplicates will be grouped
# together otherwise it'll be difficult to remove duplicate results.
#
# Run an index i from 0 to nums.length-3 (return [] if nums.length < 3)
# for each i, set j to the right of i, and k at the end (two pointers).
#
# [a1, a2, a3, ... , an]
#  |   |             |
#  i   j             k
#
# If nums[j] + nums[k] < -nums[i], it means that nums[j] is too small
# so we increase j by 1, otherwise it means that nums[k] is too big,
# so we decrease k by 1. if we found one that nums[j] + nums[k] ==
# -nums[i] we add it to the result and j++ k--, we stop if j and k
# across (j > k).
#
# To deal with duplicates: skip i if nums[i] == nums[i-1] cuz for
# [-1,-1,2] we have to deal with first -1 first otherwize we'll miss
# -1+-1+2==0. If we've found a solution, skip j if nums[j] ==
# nums[j+1], skip k if nums[k] == nums[k-1].

# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum(nums)
  return [] if nums.length < 3
  nums.sort!
  [].tap do |ret|
    (0..nums.length-3).each do |i|
      next if i > 0 && nums[i] == nums[i-1]
      j = i + 1
      k = nums.length - 1
      while j < k
        sum = nums[i] + nums[j] + nums[k]
        if sum > 0
          k -= 1
        elsif sum < 0
          j += 1
        else
          ret << [nums[i], nums[j], nums[k]]
          j += 1 until nums[j] != nums[j+1]
          k -= 1 until nums[k] != nums[k-1]
          k -= 1
          j += 1
        end
      end
    end
  end
end
