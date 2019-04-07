# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=9 lang=ruby
#
# [9] Palindrome Number
#
# https://leetcode.com/problems/palindrome-number/description/
#
# Determine whether an integer is a palindrome. An integer is a
# palindrome when it reads the same backward as forward.
#
# Example 1:
#
# Input: 121
# Output: true
#
# Example 2:
#
# Input: -121
# Output: false
# Explanation: From left to right, it reads -121. From right to left, it
# becomes 121-. Therefore it is not a palindrome.
#
# Example 3:
#
# Input: 10
# Output: false
# Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
#
# Follow up:
#
# Coud you solve it without converting the integer to a string?


# @param {Integer} x
# @return {Boolean}
def is_palindrome(x)
  return false if x < 0 || (x != 0 && x % 10 == 0)
  n = 0
  while x > n
    n = n*10 + x%10
    x = x/10
  end
  n == x || x == n/10
end
