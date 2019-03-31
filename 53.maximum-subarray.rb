# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=53 lang=ruby
#
# [53] Maximum Subarray
#
# https://leetcode.com/problems/maximum-subarray/description/
#
# Given an integer array nums, find the contiguous
# subarray (containing at least one number) which has the largest sum
# and return its sum.
#
# Example:
#
# Input: [-2,1,-3,4,-1,2,1,-5,4],
# Output: 6
# Explanation: [4,-1,2,1] has the largest sum = 6.
#
# Follow up:
#
# If you have figured out the O(n) solution, try coding another solution using
# the divide and conquer approach, which is more subtle.


# 1. S is the prefix sum: s[i] == nums[0]+nums[1]+...+nums[i].
# 2. Given r, we want to find such l <= r, so that s[r]-s[l-1] is
#    maximal, it's clear that we need s[l-1] to be minimum of
#    s[0..r-1], from here, we have the solution.
# 3. To implemen it, we don't need to build the prefix array S, we just
#    need the current partial sum and keep record of the minium
#    partial sum before it.
# 4. For nums size of 1, the result is the only element in it.

# @param {Integer[]} nums
# @return {Integer}
def max_sub_array_a(nums)
  ans = nums[0]
  sum = min_sum = 0
  (0...nums.size).each do |i|
    sum += nums[i]
    ans = [ans, sum-min_sum].max
    min_sum = [min_sum, sum].min
  end
  ans
end


# The above function only return a numerical answer, we can find the
# boundaries of the sub array too:

def max_sub_array_indices_a(nums)
  ans = nums[0]
  lo = hi = 0
  sum = min_sum = 0
  min_p = -1
  (0...nums.size).each do |i|
    sum += nums[i]
    k = sum - min_sum
    if k > ans
      ans = k
      lo = min_p + 1
      hi = i
    end
    if sum < min_sum
      min_sum = sum
      min_p = i
    end
  end
  [lo, hi]
end


# Jay Kadane's algo: same idea as above, but if at some point s[i] is
# negative, we just assign s[i]=0.
#
# See: https://en.wikipedia.org/wiki/Maximum_subarray_problem

def max_sub_array(nums)
  ans = nums[0]
  sum = 0
  (0...nums.size).each do |i|
    sum += nums[i]
    ans = [ans, sum].max
    sum = [sum, 0].max
  end
  ans
end

def max_sub_array_indices(nums)
  ans = nums[0]
  lo = hi = 0
  sum = 0
  minus_p = -1
  (0...nums.size).each do |i|
    sum += nums[i]
    if sum > ans
      sum = ans
      lo = minus_p + 1
      hi = i
    end
    if sum < 0
      sum = 0
      minus_p = i
    end
  end
  [lo, hi]
end
