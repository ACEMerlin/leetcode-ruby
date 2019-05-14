# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=172 lang=ruby
#
# [172] Factorial Trailing Zeroes
#
# https://leetcode.com/problems/factorial-trailing-zeroes/description/
#
# Given an integer n, return the number of trailing zeroes in n!.
#
# Example 1:
#
# Input: 3
# Output: 0
# Explanation: 3! = 6, no trailing zero.
#
# Example 2:
#
# Input: 5
# Output: 1
# Explanation: 5! = 120, one trailing zero.
#
# Note: Your solution should be in logarithmic time complexity.


# trailing zeroes come from 2*5=10,2*5*5,...
# Count the number of 5,5*5,...

# @param {Integer} n
# @return {Integer}
def trailing_zeroes(n)
  i, ans = 5, 0
  while n/i > 0
    ans += n/i
    i *= 5
  end
  ans
end
