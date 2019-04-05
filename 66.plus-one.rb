# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=66 lang=ruby
#
# [66] Plus One
#
# https://leetcode.com/problems/plus-one/description/
#
# Given a non-empty array of digits representing a non-negative
# integer, plus one to the integer.
#
# The digits are stored such that the most significant digit is at the head of
# the list, and each element in the array contain a single digit.
#
# You may assume the integer does not contain any leading zero, except
# the number 0 itself.
#
# Example 1:
#
# Input: [1,2,3]
# Output: [1,2,4]
# Explanation: The array represents the integer 123.
#
# Example 2:
#
# Input: [4,3,2,1]
# Output: [4,3,2,2]
# Explanation: The array represents the integer 4321.


# Ruby...

# @param {Integer[]} digits
# @return {Integer[]}
def plus_one(digits)
  digits.join.to_i.succ.to_s.chars.map(&:to_i)
end


# Or waste your time and wirte this.
def plus_one_a(digits)
  (digits.size-1).downto(0) do |i|
    if digits[i] < 9
      digits[i] += 1
      return digits
    end
    digits[i] = 0
  end
  digits.unshift 1
end
