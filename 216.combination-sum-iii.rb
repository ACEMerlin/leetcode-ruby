# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=216 lang=ruby
#
# [216] Combination Sum III
#
# https://leetcode.com/problems/combination-sum-iii/description/
#
# Find all possible combinations of k numbers that add up to a number
# n, given that only numbers from 1 to 9 can be used and each
# combination should be a unique set of numbers.
#
# Note:
#
# All numbers will be positive integers.
# The solution set must not contain duplicate combinations.
#
# Example 1:
#
# Input: k = 3, n = 7
# Output: [[1,2,4]]
#
# Example 2:
#
# Input: k = 3, n = 9
# Output: [[1,2,6], [1,3,5], [2,3,4]]


# DFS+Backtracking.

# @param {Integer} k
# @param {Integer} n
# @return {Integer[][]}
def combination_sum3(k, n, a=(1..9).to_a, i=0, sum=0, path=[], paths=[])
  return if path.size > k || sum > n
  if sum == n && path.size == k
    paths << path.dup
  else
    (i..8).each do |j|
      path << a[j]
      combination_sum3(k, n, a, j+1, sum+a[j], path, paths)
      path.pop
    end
  end
  paths
end
