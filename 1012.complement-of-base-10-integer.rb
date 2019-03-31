# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1012 lang=ruby
#
# [1012] Complement of Base 10 Integer
#
# https://leetcode.com/problems/complement-of-base-10-integer/description/
#
# Every non-negative integer N has a binary representation. For
# example, 5 can be represented as "101" in binary, 11 as "1011" in
# binary, and so on.Note that except for N = 0, there are no leading
# zeroes in any binary representation.
#
# The complement of a binary representation is the number in binary
# you get when changing every 1 to a 0 and 0 to a 1. For example, the
# complement of "101" in binary is "010" in binary.
#
# For a given number N in base-10, return the complement of it's
# binary representation as a base-10 integer.
#
# Example 1:
#
# Input: 5
# Output: 2
# Explanation: 5 is "101" in binary, with complement "010" in binary,
# which is 2 in base-10.
#
# Example 2:
#
# Input: 7
# Output: 0
# Explanation: 7 is "111" in binary, with complement "000" in binary,
# which is 0 in base-10.
#
# Example 3:
#
# Input: 10
# Output: 5
# Explanation: 10 is "1010" in binary, with complement "0101" in
# binary, which is 5 in base-10.
#
# Note:
#
# 0 <= N < 10^9


# Ruby...

# @param {Integer} n
# @return {Integer}
def bitwise_complement_a(n)
  return 1 if n == 0
  s = ""
  n.bit_length.times do |i|
    s.prepend n[i] == 1 ? '0' : '1'
  end
  s.to_i(2)
end


# Or, use Math:
#
#   1. n ^ complement(n) = 11...11
#   2. complement(n) = 11...11 ^ n

def bitwise_complement(n)
  return 1 if n == 0
  n ^ (1<<n.bit_length)-1
end
