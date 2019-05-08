# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=34 lang=ruby
#
# [34] Find First and Last Position of Element in Sorted Array
#
# https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/description/
#
# Given an array of integers nums sorted in ascending order, find the
# starting and ending position of a given target value.
#
# Your algorithm's runtime complexity must be in the order of O(log n).
#
# If the target is not found in the array, return [-1, -1].
#
# Example 1:
#
# Input: nums = [5,7,7,8,8,10], target = 8
# Output: [3,4]
#
# Example 2:
#
# Input: nums = [5,7,7,8,8,10], target = 6
# Output: [-1,-1]


# Binary Search.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def search_range(nums, target)
  i = nums.bsearch_index { |x| x >= target }
  return [-1, -1] if i.nil? || nums[i] != target
  j = i
  j += 1 while nums[j] == target
  [i, j-1]
end
