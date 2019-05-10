# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=50 lang=ruby
#
# [50] Pow(x, n)
#
# https://leetcode.com/problems/powx-n/description/
#
# Implement pow(x, n), which calculates x raised to the power n (xn).
#
# Example 1:
#
# Input: 2.00000, 10
# Output: 1024.00000
#
# Example 2:
#
# Input: 2.10000, 3
# Output: 9.26100
#
# Example 3:
#
# Input: 2.00000, -2
# Output: 0.25000
# Explanation: 2-2 = 1/22 = 1/4 = 0.25
#
# Note:
#
# -100.0 < x < 100.0
# n is a 32-bit signed integer, within the range [−231, 231 − 1]


# @param {Float} x
# @param {Integer} n
# @return {Float}
def my_pow(x, n)
  return 1 if n == 0
  return 1.fdiv(my_pow(x, -n)) if n < 0
  helper(x, n)
end

def helper(x, n)
  return x if n == 1
  m = helper(x, n/2)
  n.odd? ? m*m*x : m*m
end
