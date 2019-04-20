# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=704 lang=ruby
#
# [704] Binary Search
#
# https://leetcode.com/problems/binary-search/description/
#
# Given a sorted (in ascending order) integer array nums of n elements
# and a target value, write a function to search target in nums. If
# target exists, then return its index, otherwise return -1.
#
# Example 1:
#
# Input: nums = [-1,0,3,5,9,12], target = 9
# Output: 4
# Explanation: 9 exists in nums and its index is 4
#
# Example 2:
#
# Input: nums = [-1,0,3,5,9,12], target = 2
# Output: -1
# Explanation: 2 does not exist in nums so return -1
#
# Note:
#
# You may assume that all elements in nums are unique.
# n will be in the range [1, 10000].
# The value of each element in nums will be in the range [-9999, 9999].


# Ruby.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
  nums.bsearch_index { |x| x >= target } || -1
end


# Or this.

def search(nums, target)
  lo, hi = 0, nums.size-1
  while lo < hi
    m = lo+(hi-lo)/2
    if nums[m] >= target
      hi = m
    else
      lo = m+1
    end
  end
  nums[lo] == target ? lo : -1
end
