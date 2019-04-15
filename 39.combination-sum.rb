# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=39 lang=ruby
#
# [39] Combination Sum
#
# https://leetcode.com/problems/combination-sum/description/
#
# Given a set of candidate numbers (candidates) (without duplicates)
# and a target number (target), find all unique combinations in
# candidates where the candidate numbers sums to target.
#
# The same repeated number may be chosen from candidates unlimited
# number of times.
#
# Note:
#
# All numbers (including target) will be positive integers. The
# solution set must not contain duplicate combinations.
#
# Example 1:
#
# Input: candidates = [2,3,6,7], target = 7,
# A solution set is:
# [
# ⁠ [7],
# ⁠ [2,2,3]
# ]
#
# Example 2:
#
# Input: candidates = [2,3,5], target = 8,
# A solution set is:
# [
# [2,2,2,2],
# [2,3,3],
# [3,5]
# ]


# DFS+Backtracking.
#
#   1. why (k..n-1)? Cuz we don't want to reuse item: Given,
#      a=[2,3,5],target=8, if we aleady found 3+5==8, we don't want to
#      consider 5+3.
#   2. why recurring on the same i? Cuz we want to reuse the same item.

# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target, k=0, sum=0, path=[], paths=[])
  return [] if candidates.empty?
  return if sum > target
  if sum == target
    paths << path.dup
  else
    (k..candidates.size-1).each do |i|
      x = candidates[i]
      path << x
      combination_sum(candidates, target, i, sum+x, path, paths)
      path.pop
    end
  end
  paths
end
