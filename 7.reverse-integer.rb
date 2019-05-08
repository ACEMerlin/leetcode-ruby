# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=7 lang=ruby
#
# [7] Reverse Integer
#
# https://leetcode.com/problems/reverse-integer/description/
#
# Given a 32-bit signed integer, reverse digits of an integer.
#
# Example 1:
#
# Input: 123
# Output: 321
#
# Example 2:
#
# Input: -123
# Output: -321
#
# Example 3:
#
# Input: 120
# Output: 21
#
# Note:
# Assume we are dealing with an environment which could only store integers
# within the 32-bit signed integer range: [−231, 231 − 1]. For the purpose of
# this problem, assume that your function returns 0 when the reversed integer
# overflows.


# Ruby.

# @param {Integer} x
# @return {Integer}
def reverse(x)
  r = x.abs.digits.reverse.join.to_i
  r = x < 0 ? -r : r
  return 0 if r < -(2**31) || r > (2**31)-1
  r
end
