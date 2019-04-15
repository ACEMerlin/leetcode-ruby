# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=78 lang=ruby
#
# [78] Subsets
#
# https://leetcode.com/problems/subsets/description/
#
# Given a set of distinct integers, nums, return all possible subsets
# (the power set).
#
# Note: The solution set must not contain duplicate subsets.
#
# Example:
#
# Input: nums = [1,2,3]
# Output:
# [
# ⁠ [3],
# [1],
# [2],
# [1,2,3],
# [1,3],
# [2,3],
# [1,2],
# []
# ]


# Recursive function P either removes the first character from its
# argument, or does not. Here + means set union, . means concatenation
# and λ is the empty set

# P[3] => [] + [3]
# P[2,3] => P[3] + 2.p[3] => [] + [3] + [2] + [2,3]
# P[1,2,3] => P[2,3] + 1.P[2,3] => [] + [3] + [2] + [2,3] + [1] + [1,3] + [1,2] + [1,2,3]

# @param {Integer[]} nums
# @return {Integer[][]}
def subsets(nums, pos = 0)
  return [[], [nums[pos]]] if pos == nums.length-1
  sub = subsets(nums, pos+1)
  sub + sub.map { |c| c + [nums[pos]] }
end


# DFS+Backtracking.

def subsets(nums, k=0, path=[], paths=[[]])
  return [] if nums.empty?
  return if k == nums.size
  (k..nums.size-1).each do |i|
    path << nums[i]
    paths << path.dup
    subsets(nums, i+1, path, paths)
    path.pop
  end
  paths
end
