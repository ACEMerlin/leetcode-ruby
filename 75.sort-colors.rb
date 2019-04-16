# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=75 lang=ruby
#
# [75] Sort Colors
#
# https://leetcode.com/problems/sort-colors/description/
#
# Given an array with n objects colored red, white or blue, sort them
# in-place so that objects of the same color are adjacent, with the
# colors in the order red, white and blue.
#
# Here, we will use the integers 0, 1, and 2 to represent the color
# red, white, and blue respectively.
#
# Note: You are not suppose to use the library's sort function for this
# problem.
#
# Example:
#
# Input: [2,0,2,1,1,0]
# Output: [0,0,1,1,2,2]
#
# Follow up:
#
# A rather straight forward solution is a two-pass algorithm using counting
# sort.
# First, iterate the array counting number of 0's, 1's, and 2's, then overwrite
# array with total number of 0's, then 1's and followed by 2's.
# Could you come up with a one-pass algorithm using only constant space?


# Three way partitioning from quick sort. See problem 215.

# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def sort_colors(nums)
  three_way_partition(nums)
end

def three_way_partition(nums, lo=0, hi=nums.size-1)
  lt, gt, k = lo, hi, lo
  while k <= gt
    cmp = nums[k] <=> 1
    case cmp
    when -1
      swap(nums, lt, k)
      lt += 1
      k += 1
    when 1
      swap(nums, gt, k)
      gt -= 1
    when 0
      k += 1
    end
  end
end

def swap(nums, i, j)
  nums[i], nums[j] = nums[j], nums[i]
end
