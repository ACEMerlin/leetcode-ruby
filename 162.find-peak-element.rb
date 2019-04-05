# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=162 lang=ruby
#
# [162] Find Peak Element
#
# https://leetcode.com/problems/find-peak-element/description/
#
# A peak element is an element that is greater than its neighbors.
#
# Given an input array nums, where nums[i] ≠ nums[i+1], find a peak
# element and return its index.
#
# The array may contain multiple peaks, in that case return the index
# to any one of the peaks is fine.
#
# You may imagine that nums[-1] = nums[n] = -∞.
#
# Example 1:
#
# Input: nums = [1,2,3,1]
# Output: 2
# Explanation: 3 is a peak element and your function should return the
# index number 2.
#
# Example 2:
#
# Input: nums = [1,2,1,3,5,6,4]
# Output: 1 or 5
# Explanation: Your function can return either index number 1 where
# the peak element is 2, or index number 5 where the peak element is 6.
#
# Note: Your solution should be in logarithmic complexity.


# See https://courses.csail.mit.edu/6.006/spring11/lectures/lec02.pdf

# @param {Integer[]} nums
# @return {Integer}
def find_peak_element(nums, lo=0, hi=nums.size-1)
  m = (lo + hi) / 2
  if m > 0 && nums[m] < nums[m-1]
    find_peak_element(nums, lo, m-1)
  elsif m < nums.size-1 && nums[m] < nums[m+1]
    find_peak_element(nums, m+1, hi)
  else
    m
  end
end
