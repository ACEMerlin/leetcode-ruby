# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=33 lang=ruby
#
# [33] Search in Rotated Sorted Array
#
# https://leetcode.com/problems/search-in-rotated-sorted-array/description/
#
# Suppose an array sorted in ascending order is rotated at some pivot
# unknown to you beforehand.
#
# (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).
#
# You are given a target value to search. If found in the array return
# its index, otherwise return -1.
#
# You may assume no duplicate exists in the array.
#
# Your algorithm's runtime complexity must be in the order of O(log n).
#
# Example 1:
#
# Input: nums = [4,5,6,7,0,1,2], target = 0
# Output: 4
#
# Example 2:
#
# Input: nums = [4,5,6,7,0,1,2], target = 3
# Output: -1


# Here are all the possible search condition:
#
# [4,5,6,7,0,1,2]
#   mid >= left
#   - x<mid && x>=left then go left
#   - else got right
# [5,6,0,1,2,3,4]
#   mid < left
#   - x>mid && x<=right then go right
#   - else go left

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
  i, j = 0, nums.length-1
  while i <= j
    mid = (i + j) / 2
    if nums[mid] == target
      return mid
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
  -1
end

