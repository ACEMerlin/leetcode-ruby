# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=136 lang=ruby
#
# [136] Single Number
#
# https://leetcode.com/problems/single-number/description/
#
# Given a non-empty array of integers, every element appears twice
# except for one. Find that single one.
#
# Note:
#
# Your algorithm should have a linear runtime complexity. Could you
# implement it without using extra memory?
#
# Example 1:
#
# Input: [2,2,1]
# Output: 1
#
# Example 2:
#
# Input: [4,1,2,1,2]
# Output: 4


# @param {Integer[]} nums
# @return {Integer}
def single_number_a(nums)
  s = Set.new
  nums.each do |n|
    if s.include?(n)
      s.delete(n)
    else
      s << n
    end
  end
  s.first
end


# The second method is brilliant, it uses the XOR operator(^).
#
#   1. a ^ 0 = 0 ^ a = a
#   2. a ^ a = 0
#   3. a ^ b ^ a = a ^ a ^ b = 0 ^ b = b
#
# So just reduce the list by XOR.

def single_number(nums)
  nums.reduce(&:^)
end
