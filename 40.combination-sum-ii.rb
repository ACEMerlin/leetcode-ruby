# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=40 lang=ruby
#
# [40] Combination Sum II
#
# https://leetcode.com/problems/combination-sum-ii/description/
#
# Given a collection of candidate numbers (candidates) and a target
# number (target), find all unique combinations in candidates where
# the candidate numbers sums to target.
# 
# Each number in candidates may only be used once in the combination.
# 
# Note:
# 
# All numbers (including target) will be positive integers.
# The solution set must not contain duplicate combinations.
# 
# Example 1:
# 
# Input: candidates = [10,1,2,7,6,1,5], target = 8,
# A solution set is:
# [
# ⁠ [1, 7],
# ⁠ [1, 2, 5],
# ⁠ [2, 6],
# ⁠ [1, 1, 6]
# ]
# 
# Example 2:
# 
# Input: candidates = [2,5,2,1,2], target = 5,
# A solution set is:
# [
# [1,2,2],
# [5]
# ]


# DFS+Backtracking.

# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum2(candidates, target)
  dfs(candidates.sort, target)
end

def dfs(a, target, k=0, sum=0, path=[], paths=[])
  return [] if a.empty?
  return if sum > target
  if sum == target
    paths << path.dup
  else
    (k..a.size-1).each do |i|
      next if i > k && a[i] == a[i-1]
      path << a[i]
      dfs(a, target, i+1, sum+a[i], path, paths)
      path.pop
    end
  end
  paths
end
