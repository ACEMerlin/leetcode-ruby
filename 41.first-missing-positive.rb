# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=41 lang=ruby
#
# [41] First Missing Positive
#
# https://leetcode.com/problems/first-missing-positive/description/
#
# Given an unsorted integer array, find the smallest missing positive integer.
#
# Example 1:
#
# Input: [1,2,0]
# Output: 3
#
# Example 2:
#
# Input: [3,4,-1,1]
# Output: 2
#
# Example 3:
#
# Input: [7,8,9,11,12]
# Output: 1
#
# Note:
#
# Your algorithm should run in O(n) time and uses constant extra space.


# O(n) space.

# @param {Integer[]} nums
# @return {Integer}
def first_missing_positive(nums)
  s = nums.size
  xs = Array.new(s+1)
  nums.each do |n|
    xs[n] = n if n > 0 && n <= s
  end
  (1..s).each do |i|
    return i if xs[i].nil?
  end
  xs.size
end


# O(1) space.

def first_missing_positive(nums)
  s = nums.size
  (0..s-1).each do |i|
    while nums[i] > 0 && nums[i] <= s && nums[nums[i]-1] != nums[i]
      nums[nums[i]-1], nums[i] = nums[i], nums[nums[i]-1]
    end
  end
  (0..s-1).each do |i|
    return i+1 if nums[i] != i+1
  end
  s+1
end
