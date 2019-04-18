# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=238 lang=ruby
#
# [238] Product of Array Except Self
#
# https://leetcode.com/problems/product-of-array-except-self/description/
#
# Given an array nums of n integers where n > 1, return an array
# output such that output[i] is equal to the product of all the
# elements of nums except nums[i].
#
# Example:
#
# Input:  [1,2,3,4]
# Output: [24,12,8,6]
#
# Note: Please solve it without division and in O(n).
#
# Follow up:
# Could you solve it with constant space complexity? (The output array does not
# count as extra space for the purpose of space complexity analysis.)


# See problem 42, same idea: two passes, left to right, right to left.

# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self(nums)
  l = nums.reduce([1]) { |h, n| h << h[-1]*n }
  r = nums.reverse_each.reduce([1]) { |h, n| h.unshift(h[0]*n) }
  nums.size.times.map do |i|
    l[i] * r[i+1]
  end
end


# The second pass is unnecessary.

def product_except_self(nums)
  l = nums.reduce([1]) { |h, n| h << h[-1]*n }
  t, ans = 1, []
  (nums.size-1).downto(0) do |i|
    ans.unshift(l[i] * t)
    t *= nums[i]
  end
  ans
end
