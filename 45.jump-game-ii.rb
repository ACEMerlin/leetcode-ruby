# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=45 lang=ruby
#
# [45] Jump Game II
#
# https://leetcode.com/problems/jump-game-ii/description/
#
# Given an array of non-negative integers, you are initially
# positioned at the first index of the array.
#
# Each element in the array represents your maximum jump length at
# that position.
#
# Your goal is to reach the last index in the minimum number of jumps.
#
# Example:
#
# Input: [2,3,1,1,4]
# Output: 2
# Explanation: The minimum number of jumps to reach the last index is 2.
# ⁠   Jump 1 step from index 0 to 1, then 3 steps to the last index.
#
# Note: You can assume that you can always reach the last index.


# DP O(n^2).
#
#   1. dp[i]: minimum number of steps to start at 0 and reach i.
#   2. dp[i] = min[dp[k1], ..., dp[i-1]]+1 for all 0<=k<i and k+nums[k]>=i

# @param {Integer[]} nums
# @return {Integer}
def jump_a(nums)
  dp = Array.new(nums.size, Float::INFINITY)
  dp[0] = 0
  (1...nums.size).each do |i|
    min = Float::INFINITY
    (0..i-1).each do |k|
      min = [min, dp[k]].min if k+nums[k]>=i
    end
    dp[i] = min + 1 if min != Float::INFINITY
  end
  dp[nums.size-1]
end


# Greedy O(n).
#
# If we look at the dp array of above solution, given [2,2,0,1,4],
# dp=[0,1,1,2,3]. In fact, we only care about the changing point: from
# 0 to 1, from 1 to 2, etc. If we know the farthest indices of k-2 and
# k-1 we can get farthest index of k: f(k) = max[nums[i]+i] for all
# f(k-2)+1<=i<=f(k-1)

# k2 == f(k-2)+1
# k1 == f(k-1)

def jump_b(nums)
  return 0 if nums.size == 1
  k1 = k2 = ans = 0
  while k1 < nums.size-1
    max = k1
    (k2..k1).each do |i|
      return ans+1 if i+nums[i] >= nums.size-1
      max = [max, i+nums[i]].max
    end
    k2 = k1+1
    k1 = max
    ans += 1
  end
end


# Or you can sit down and figure out how to use one loop.

def jump(nums)
  return 0 if nums.size == 1
  k1 = k2 = ans = 0
  (0..nums.size-2).each do |i|
    return ans+1 if i+nums[i] >= nums.size-1
    k1 = [k1, i+nums[i]].max
    if i == k2
      ans += 1
      k2 = k1
    end
  end
end
