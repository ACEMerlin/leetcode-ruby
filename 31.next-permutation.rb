# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=31 lang=ruby
#
# [31] Next Permutation
#
# https://leetcode.com/problems/next-permutation/description/
#
# Implement next permutation, which rearranges numbers into the
# lexicographically next greater permutation of numbers.
#
# If such arrangement is not possible, it must rearrange it as the
# lowest possible order (ie, sorted in ascending order).
#
# The replacement must be in-place and use only constant extra memory.
#
# Here are some examples. Inputs are in the left-hand column and its
# corresponding outputs are in the right-hand column.
#
# 1,2,3 → 1,3,2
# 3,2,1 → 1,2,3
# 1,1,5 → 1,5,1


# See https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order

# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def next_permutation(nums)
  n, k, l = nums.size
  (n-2).downto(0).each do |i|
    k = i and break if nums[i] < nums[i+1]
  end
  nums.sort! and return if k.nil?
  (n-1).downto(k+1).each do |i|
    l = i and break if nums[i] > nums[k]
  end
  swap(nums, k, l)
  reverse(nums, k+1, n-1)
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
