# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=70 lang=ruby
#
# [70] Climbing Stairs
#
# https://leetcode.com/problems/climbing-stairs/description/
#
# You are climbing a stair case. It takes n steps to reach to the top.
#
# Each time you can either climb 1 or 2 steps. In how many distinct
# ways can you climb to the top?
#
# Note: Given n will be a positive integer.
#
# Example 1:
#
# Input: 2
# Output: 2
# Explanation: There are two ways to climb to the top.
# 1. 1 step + 1 step
# 2. 2 steps
#
# Example 2:
#
# Input: 3
# Output: 3
# Explanation: There are three ways to climb to the top.
# 1. 1 step + 1 step + 1 step
# 2. 1 step + 2 steps
# 3. 2 steps + 1 step


# @param {Integer} n
# @return {Integer}
def climb_stairs(n)
  Hash.new { |h, k| h[k] = h[k-1] + h[k-2] }.merge({1=>1, 2=>2})[n]
end
