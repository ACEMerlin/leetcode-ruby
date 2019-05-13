# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=228 lang=ruby
#
# [228] Summary Ranges
#
# https://leetcode.com/problems/summary-ranges/description/
#
# Given a sorted integer array without duplicates, return the summary
# of its ranges.
#
# Example 1:
#
# Input:  [0,1,2,4,5,7]
# Output: ["0->2","4->5","7"]
# Explanation: 0,1,2 form a continuous range; 4,5 form a continuous range.
#
# Example 2:
#
# Input:  [0,2,3,4,6,8,9]
# Output: ["0","2->4","6","8->9"]
# Explanation: 2,3,4 form a continuous range; 8,9 form a continuous range.


# @param {Integer[]} nums
# @return {String[]}
def summary_ranges(nums, r=[])
  return [] if nums.empty?
  i = 0
  i += 1 while i+1 < nums.size && nums[i+1] == nums[i]+1
  i == 0 ? r << "#{nums[0]}" : r << "#{nums[0]}->#{nums[i]}"
  summary_ranges(nums[i+1..-1], r)
  r
end
