# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=198 lang=ruby
#
# [198] House Robber
#
# https://leetcode.com/problems/house-robber/description/
#
# You are a professional robber planning to rob houses along a street.
# Each house has a certain amount of money stashed, the only
# constraint stopping you from robbing each of them is that adjacent
# houses have security system connected and it will automatically
# contact the police if two adjacent houses were broken into on the
# same night.
#
# Given a list of non-negative integers representing the amount of
# money of each house, determine the maximum amount of money you can
# rob tonight without alerting the police.
#
# Example 1:
#
# Input: [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money =
# 3).
# Total amount you can rob = 1 + 3 = 4.
#
# Example 2:
#
# Input: [2,7,9,3,1]
# Output: 12
# Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5
# (money = 1).
# Total amount you can rob = 2 + 9 + 1 = 12.


# Classic DP problem.
#
#   1. dp[i]: the maximum amount of money we can rob from house 0 to i.
#   2. If we rob the ith house, then dp[i] = dp[i-2]+nums[i].
#   3. If we don't rob the ith house, then dp[i] = dp[i-1].
#   4. Pick the maximum of step 2 and step 3 as dp[i].
#   5. Only one house, just rob it: dp[0] = nums[0].
#   6. No house, can't rob anyone: dp[-1] = 0.

# @param {Integer[]} nums
# @return {Integer}
def rob_a(nums)
  return 0 if nums.empty?
  n = nums.size
  dp = Array.new(n+1, 0)
  dp[0] = nums[0]
  (1...n).each do |i|
    dp[i] = [dp[i-2]+nums[i], dp[i-1]].max
  end
  dp[n-1]
end


# One observation of above code is that we only need dp[i-2] and
# dp[i-1] to produce dp[i], so just store them in two variables.

def rob(nums)
  return 0 if nums.empty?
  d2 = d1 = 0
  nums.each do |n|
    d1, d2 = [d2+n, d1].max, d1
  end
  d1
end
