# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1 lang=ruby
#
# [1] Two Sum
#
# https://leetcode.com/problems/two-sum/description/
#
# Given an array of integers, return indices of the two numbers such
# that they add up to a specific target.
#
# You may assume that each input would have exactly one solution, and
# you may not use the same element twice.
#
# Example:
#
# Given nums = [2, 7, 11, 15], target = 9,
# Because nums[0] + nums[1] = 2 + 7 = 9,
# return [0, 1].


# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  hash = {}
  nums.each_with_index { |x, i|
    return [hash[target-x], i] if hash.has_key?(target-x)
    hash[x] = i
  }
end
