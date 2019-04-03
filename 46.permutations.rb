# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=46 lang=ruby
#
# [46] Permutations
#
# https://leetcode.com/problems/permutations/description/
#
# Given a collection of distinct integers, return all possible
# permutations.
#
# Example:
#
# Input: [1,2,3]
# Output:
# [
# ⁠ [1,2,3],
# ⁠ [1,3,2],
# ⁠ [2,1,3],
# ⁠ [2,3,1],
# ⁠ [3,1,2],
# ⁠ [3,2,1]
# ]


# See
#   - https://en.wikipedia.org/wiki/Permutation
#   - https://www.cs.princeton.edu/courses/archive/fall12/cos226/lectures/67CombinatorialSearch.pdf
#
#   1. Fix numbers up to given point k.
#   2. Permute the rest of it recursively.
#
# Example: given "xyz"
#
# - x followed by all permutations of y and z (yz and zy)
# - y followed by all permutations of x and z (xz and zx)
# - z followed by all permutations of x and y (xy and yx)

# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums, k=0, ans=[])
  ans << nums.dup and return if k == nums.size
  (k...nums.size).each do |i|
    swap(nums, k, i)            # fix nums[k] using nums[i]
    permute(nums, k+1, ans)     # permute the rest
    swap(nums, k, i)            # revert nums[k] to initial state
  end
  ans
end

def swap(nums, i, j)
  nums[i], nums[j] = nums[j], nums[i]
end
