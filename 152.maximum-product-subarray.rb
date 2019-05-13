# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=152 lang=ruby
#
# [152] Maximum Product Subarray
#
# https://leetcode.com/problems/maximum-product-subarray/description/
#
# Given an integer array nums, find the contiguous subarray within an array
# (containing at least one number) which has the largest product.
#
# Example 1:
#
# Input: [2,3,-2,4]
# Output: 6
# Explanation: [2,3] has the largest product 6.
#
# Example 2:
#
# Input: [-2,0,-1]
# Output: 0
# Explanation: The result cannot be 2, because [-2,-1] is not a subarray.


# DP.

# @param {Integer[]} nums
# @return {Integer}
def max_product(nums)
  n, ans = nums.size, -Float::INFINITY
  d = Array.new(n+1).tap { |d| d[n] = [1, 1] }
  (n-1).downto(0).each do |i|
    min, max = (d[i+1].map { |s| s * nums[i] } + [nums[i]]).minmax
    if max < 0
      d[i] = [min, min]
    elsif min > 0
      d[i] = [max, max]
    else
      d[i] = [min, max]
    end
    ans = [ans, d[i][1]].max
  end
  ans
end
