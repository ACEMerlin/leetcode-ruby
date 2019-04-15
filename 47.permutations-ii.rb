# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=47 lang=ruby
#
# [47] Permutations II
#
# https://leetcode.com/problems/permutations-ii/description/
#
# Given a collection of numbers that might contain duplicates, return
# all possible unique permutations.
#
# Example:
#
# Input: [1,1,2]
# Output:
# [
# ⁠ [1,1,2],
# ⁠ [1,2,1],
# ⁠ [2,1,1]
# ]


# See problem 46. The idea is not to fix the number we've already fixed.
#
# See https://en.wikipedia.org/wiki/Permutation#Permutations_of_multisets
#
# Example: given "xxy"
#
# - x followed by all permutations of x and y (xy and yx)
# - do not fix the second x in position 0
# - y followed by all permutations of x and x (xx)

# @param {Integer[]} nums
# @return {Integer[][]}
def permute_unique(nums, k=0, ans=[])
  ans << nums.dup and return if k == nums.size
  seen = Set.new
  (k...nums.size).each do |i|
    next if seen.include?(nums[i])
    seen << nums[i]
    swap(nums, k, i)
    permute_unique(nums, k+1, ans)
    swap(nums, k, i)
  end
  ans
end

def swap(nums, i, j)
  nums[i], nums[j] = nums[j], nums[i]
end


# DFS+Backtracking.

def permute_unique(nums, seen=Set.new, path=[], paths=[])
  if path.size == nums.size
    paths << path.dup
  else
    same_level = Set.new
    (0..nums.size-1).each do |i|
      next if seen.include?(i) || same_level.include?(nums[i])
      seen << i
      same_level << nums[i]
      path << nums[i]
      permute_unique(nums, seen, path, paths)
      path.pop
      seen.delete(i)
    end
  end
  paths
end
