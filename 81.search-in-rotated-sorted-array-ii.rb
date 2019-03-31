# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=81 lang=ruby
#
# [81] Search in Rotated Sorted Array II
#
# https://leetcode.com/problems/search-in-rotated-sorted-array-ii/description/
#
# Suppose an array sorted in ascending order is rotated at some pivot
# unknown to you beforehand.
#
# (i.e., [0,0,1,2,2,5,6] might become [2,5,6,0,0,1,2]).
#
# You are given a target value to search. If found in the array return
# true, otherwise return false.
#
# Example 1:
#
# Input: nums = [2,5,6,0,0,1,2], target = 0
# Output: true
#
# Example 2:
#
# Input: nums = [2,5,6,0,0,1,2], target = 3
# Output: false
#
# Follow up:
#
# This is a follow up problem to Search in Rotated Sorted Array, where nums may
# contain duplicates.
# Would this affect the run-time complexity? How and why?


# See problem 33.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Boolean}
def search(nums, target)
  i, j = 0, nums.length-1
  while i <= j
    mid = (i + j) / 2
    if nums[mid] == target
      return true
    elsif nums[i] == nums[j] && nums[i] == nums[mid]
      i += 1
      j -= 1
    elsif nums[mid] >= nums[i]
      if target < nums[mid] && target >= nums[i]
	j = mid - 1
      else
	i = mid + 1
      end
    else
      if target <= nums[j] && target > nums[mid]
	i = mid + 1
      else
	j = mid - 1
      end
    end
  end
  false
end
