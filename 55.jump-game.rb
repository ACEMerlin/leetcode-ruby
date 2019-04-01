# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=55 lang=ruby
#
# [55] Jump Game
#
# https://leetcode.com/problems/jump-game/description/
#
# Given an array of non-negative integers, you are initially
# positioned at the first index of the array.
#
# Each element in the array represents your maximum jump length at
# that position.
#
# Determine if you are able to reach the last index.
#
# Example 1:
#
# Input: [2,3,1,1,4]
# Output: true
# Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
#
# Example 2:
#
# Input: [3,2,1,0,4]
# Output: false
# Explanation: You will always arrive at index 3 no matter what. Its
# maximum
# jump length is 0, which makes it impossible to reach the last index.


# DP O(n^2) solution.
#
#   1. dp[i]: whether we can reach n-1 starting from i.
#   2. dp[n-1] == true.
#   3. dp[i] is true when dp[j](i<j<=nums[i]+i) is also true.

# @param {Integer[]} nums
# @return {Boolean}
def can_jump_a(nums)
  n = nums.size
  dp = Array.new(n, false)
  dp[n-1] = true
  (n-2).downto(0).each do |i|
    hi = [nums[i]+i, n-1].min
    (i+1..hi).each do |j|
      dp[i] = true and break if dp[j]
    end
  end
  dp[0]
end


# Greedy O(n) solution. The key observation is that all indices are
# reachable if the last index is reachable:
#
# Assuming that we can reach last index from i0,i1,...,ix,
# (i0<i1...<ix) using one jump, then we just need to check if we can
# reach ix from j (0<=j<ix), cuz if we can reach last index from ix,
# then we most definitely can reach i1,...,ix from j.
#
# Using above observation recursively, then j should be 0 in the end.

def can_jump(nums)
  j = nums.size - 1
  (nums.size-2).downto(0).each do |i|
    j = i if nums[i]+i >= j
  end
  j == 0
end
