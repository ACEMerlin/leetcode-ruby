# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=442 lang=ruby
#
# [442] Find All Duplicates in an Array
#
# https://leetcode.com/problems/find-all-duplicates-in-an-array/description/
#
# Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array), some
# elements appear twice and others appear once.
#
# Find all the elements that appear twice in this array.
#
# Could you do it without extra space and in O(n) runtime?
#
# Example:
#
# Input:
# [4,3,2,7,8,2,3,1]
#
# Output:
# [2,3]


# Hash.

# @param {Integer[]} nums
# @return {Integer[]}
def find_duplicates(nums)
  freq = nums.reduce(Hash.new(0)) { |h, n| h[n] += 1; h }
  freq.select { |k, v| v >= 2 }.keys
end


# O(1)

def find_duplicates(nums)
  ans = []
  nums.each do |n|
    if nums[n.abs-1] < 0
      ans << n.abs
    else
      nums[n.abs-1] *= -1
    end
  end
  ans
end
