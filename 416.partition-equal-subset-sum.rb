# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=416 lang=ruby
#
# [416] Partition Equal Subset Sum
#
# https://leetcode.com/problems/partition-equal-subset-sum/description/
#
# Given a non-empty array containing only positive integers, find if
# the array can be partitioned into two subsets such that the sum of
# elements in both subsets is equal.
#
# Note:
#
# Each of the array element will not exceed 100.
# The array size will not exceed 200.
#
# Example 1:
#
# Input: [1, 5, 11, 5]
# Output: true
# Explanation: The array can be partitioned as [1, 5, 5] and [11].
#
# Example 2:
#
# Input: [1, 2, 3, 5]
# Output: false
# Explanation: The array cannot be partitioned into equal sum subsets.


# DFS+Memo.

# @param {Integer[]} nums
# @return {Boolean}
def can_partition(nums)
  t, r = nums.sum.divmod(2)
  return false if !r.zero?
  dfs(nums, t)
end

def dfs(nums, target, k=0, sum=0, memo={})
  return memo[sum] if memo.has_key?(sum)
  if sum > target
    memo[sum] = false
  elsif sum == target
    memo[sum] = true
  else
    (k..nums.size-1).each do |i|
      if dfs(nums, target, i+1, sum+nums[i], memo)
        memo[sum] = true
        return true
      end
    end
    memo[sum] = false
  end
  memo[sum]
end


# DP.

def can_partition(nums)
  t, r = nums.sum.divmod(2)
  return false if !r.zero?
  d = Array.new(nums.size+1) { Array.new(t+1, false) }
  d[0][0] = true
  (1..nums.size).each do |i|
    (0..t).each do |j|
      d[i][j] = d[i-1][j]
      d[i][j] ||= d[i][j-nums[i-1]] if nums[i-1] <= j
    end
  end
  d[nums.size][t]
end
