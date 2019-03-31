# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=437 lang=ruby
#
# [437] Path Sum III
#
# https://leetcode.com/problems/path-sum-iii/description/
#
# You are given a binary tree in which each node contains an integer value.
#
# Find the number of paths that sum to a given value.
#
# The path does not need to start or end at the root or a leaf, but it
# must go downwards (traveling only from parent nodes to child nodes).
#
# The tree has no more than 1,000 nodes and the values are in the
# range -1,000,000 to 1,000,000.
#
# Example:
#
# root = [10,5,-3,3,2,null,11,3,-2,null,1], sum = 8
#
# ⁠     10
# ⁠    /  \
# ⁠   5   -3
# ⁠  / \    \
# ⁠ 3   2   11
# ⁠/ \   \
# 3  -2   1
#
# Return 3. The paths that sum to 8 are:
#
# 1.  5 -> 3
# 2.  5 -> 2 -> 1
# 3. -3 -> 11
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# We already solved problem 113, the naive but obvious solution'd be
# just resurcively check its left and right sub tree.

# @param {TreeNode} root
# @param {Integer} sum
# @return {Integer}
def path_sum_a(root, sum)
  return 0 if root.nil?
  dfs(root, sum) + path_sum_a(root&.left, sum) + path_sum_a(root&.right, sum)
end

def dfs(root, sum, x=0)
  return 0 if root.nil?
  r = 0
  x += root.val
  r = 1 if x == sum
  r += dfs(root.left, sum, x)
  r += dfs(root.right, sum, x)
  r
end


# See problem 560.
#
#   1. For each path from root to leaf, we can count how many 'sub
#      array's that sums up to 'sum' using the method from 560.
#   2. We need to remove the prefix sum at certain node from hash
#      after we've dealt with its sub nodes.

def path_sum(root, sum, x=0, h=Hash.new(0))
  return 0 if root.nil?
  h[0] = 1 if h[0] == 0
  x += root.val
  r = h[x-sum]
  h[x] += 1
  r += path_sum(root.left, sum, x, h)
  r += path_sum(root.right, sum, x, h)
  h[x] -= 1
  r
end
