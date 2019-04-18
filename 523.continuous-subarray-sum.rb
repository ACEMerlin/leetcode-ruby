# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=523 lang=ruby
#
# [523] Continuous Subarray Sum
#
# https://leetcode.com/problems/continuous-subarray-sum/description/
#
# Given a list of non-negative numbers and a target integer k, write a
# function to check if the array has a continuous subarray of size at
# least 2 that sums up to the multiple of k, that is, sums up to n*k
# where n is also an integer.
#
# Example 1:
#
# Input: [23, 2, 4, 6, 7],  k=6
# Output: True
# Explanation: Because [2, 4] is a continuous subarray of size 2 and
# sums up to 6.
#
# Example 2:
#
# Input: [23, 2, 6, 4, 7],  k=6
# Output: True
# Explanation: Because [23, 2, 6, 4, 7] is an continuous subarray of
# size 5 and sums up to 42.
#
# Note:
#
# The length of the array won't exceed 10,000. You may assume the sum
# of all the numbers is in the range of a signed 32-bit integer.


# 1. Let P be the prefix sum array.
# 2. We want (a[i]+a[i+1]+...+a[j])%k == 0, which is (P[j]-P[i-1])%k == 0,
#    which then is P[j]-P[i-1] = n*k, assume that P[j]%k == x1 and P[i-1]%k == x2,
#    we have P[j] = k*n1+x1 and P[i-1] = k*n2+x2, put it in we then got:
#    k*n1+x1 - k*n2+x2 = n*k, in order for this to work, we need n1-n2 == n
#    and x1 == x2. n1, n2 and n can be any number so we don't need to worry
#    about them, the only constraint we need is x1 == x2, which means that
#    P[j]%k == P[i-1]%k.
# 3. Also (a%k+b%k)%k = (a+b)%k.
# 3. Actually we only need to check longest subarray if it exists, so only update
#    the hash when it's not already inside.
# 5. Notice that when k is 0 then just leave it be, we can't mod 0.


# @param {Integer[]} nums
# @param {Integer} k
# @return {Boolean}
def check_subarray_sum(nums, k)
  sum, h = 0, {0=>-1}
  nums.each_with_index do |n, i|
    sum += n
    sum %= k if k != 0
    if h.has_key?(sum)
      return true if i-h[sum] > 1
    else
      h[sum] = i
    end
  end
  false
end
