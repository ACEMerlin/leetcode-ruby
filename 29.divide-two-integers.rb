# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=29 lang=ruby
#
# [29] Divide Two Integers
#
# https://leetcode.com/problems/divide-two-integers/description/
#
# Given two integers dividend and divisor, divide two integers without
# using multiplication, division and mod operator.
#
# Return the quotient after dividing dividend by divisor.
#
# The integer division should truncate toward zero.
#
# Example 1:
#
# Input: dividend = 10, divisor = 3
# Output: 3
#
# Example 2:
#
# Input: dividend = 7, divisor = -3
# Output: -2
#
# Note:
#
# Both dividend and divisor will be 32-bit signed integers.
# The divisor will never be 0.
# Assume we are dealing with an environment which could only store integers
# within the 32-bit signed integer range: [−231,  231 − 1]. For the purpose of
# this problem, assume that your function returns 231 − 1 when the division
# result overflows.


# Binary Search.

# @param {Integer} dividend
# @param {Integer} divisor
# @return {Integer}
def divide(dividend, divisor)
  if divisor == 1
    x = dividend
  elsif divisor == -1
    x = -dividend
  else
    d, b = dividend.abs, divisor.abs
    x = (0..d).bsearch { |x| (x+1)*b > d }
    x = (dividend > 0 && divisor < 0) || (dividend < 0 && divisor > 0) ? -x : x
  end
  x < -2**31 || x > 2**31-1 ? 2**31-1 : x
end
