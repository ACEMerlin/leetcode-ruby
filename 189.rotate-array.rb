# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=189 lang=ruby
#
# [189] Rotate Array
#
# https://leetcode.com/problems/rotate-array/description/
#
# Given an array, rotate the array to the right by k steps, where k is
# non-negative.
#
# Example 1:
#
# Input: [1,2,3,4,5,6,7] and k = 3
# Output: [5,6,7,1,2,3,4]
# Explanation:
# rotate 1 steps to the right: [7,1,2,3,4,5,6]
# rotate 2 steps to the right: [6,7,1,2,3,4,5]
# rotate 3 steps to the right: [5,6,7,1,2,3,4]
#
# Example 2:
#
# Input: [-1,-100,3,99] and k = 2
# Output: [3,99,-1,-100]
# Explanation:
# rotate 1 steps to the right: [99,-1,-100,3]
# rotate 2 steps to the right: [3,99,-1,-100]
#
# Note:
#
# Try to come up as many solutions as you can, there are at least 3 different
# ways to solve this problem.
# Could you do it in-place with O(1) extra space?


# @param {Integer[]} nums
# @param {Integer} k
# @return {Void} Do not return anything, modify nums in-place instead.
def rotate_a(nums, k)
  nums.rotate!(k)
end


def rotate_b(nums, k)
  x, n = nums.dup, nums.size
  (0..n-1).each do |i|
    nums[(i+k)%n] = x[i]
  end
end


def rotate(nums, k)
  k %= nums.length
  reverse(nums, 0, nums.size-1)
  reverse(nums, 0, k-1)
  reverse(nums, k, nums.size-1)
end

def swap(nums, i, j)
  nums[i], nums[j] = nums[j], nums[i]
end

def reverse(nums, i, j)
  until i > j
    swap(nums, i, j)
    i += 1
    j -= 1
  end
end
