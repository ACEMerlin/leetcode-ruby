# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=371 lang=ruby
#
# [371] Sum of Two Integers
#
# https://leetcode.com/problems/sum-of-two-integers/description/
#
# Calculate the sum of two integers a and b, but you are not allowed
# to use the operator + and -.
#
# Example 1:
#
# Input: a = 1, b = 2
# Output: 3
#
# Example 2:
#
# Input: a = -2, b = 3
# Output: 1


# See: https://www.youtube.com/watch?v=qq64FrA2UXQ

# @param {Integer} a
# @param {Integer} b
# @return {Integer}
def get_sum(a, b)
  a = [a].pack('l').unpack('l').first
  b = [b].pack('l').unpack('l').first
  get_sum_32bit(a, b)
end

def get_sum_32bit(a, b)
  return a if b.zero?
  return b if a.zero?
  get_sum(a^b, (a&b)<<1)
end
