# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=167 lang=ruby
#
# [167] Two Sum II - Input array is sorted
#
# https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/
#
# Given an array of integers that is already sorted in ascending
# order, find two numbers such that they add up to a specific target
# number.
#
# The function twoSum should return indices of the two numbers such
# that they add up to the target, where index1 must be less than
# index2.
#
# Note:
#
# Your returned answers (both index1 and index2) are not zero-based.
# You may assume that each input would have exactly one solution and
# you may not use the same element twice.
#
# Example:
#
# Input: numbers = [2,7,11,15], target = 9
# Output: [1,2]
# Explanation: The sum of 2 and 7 is 9. Therefore index1 = 1, index2 = 2.


# @param {Integer[]} numbers
# @param {Integer} target
# @return {Integer[]}
def two_sum(numbers, target)
  i, j = 0, numbers.size-1
  while i < j
    sum = numbers[i] + numbers[j]
    cmp = sum <=> target
    case cmp
    when 1
      j -= 1
    when -1
      i += 1
    else
      return [i+1, j+1]
    end
  end
end
