# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=113 lang=ruby
#
# [113] Path Sum II
#
# https://leetcode.com/problems/path-sum-ii/description/
#
# Given a binary tree and a sum, find all root-to-leaf paths where
# each path's sum equals the given sum.
#
# Note: A leaf is a node with no children.
#
# Example:
#
# Given the below binary tree and sum = 22,
#
# ⁠     5
# ⁠    / \
# ⁠   4   8
# ⁠  /   / \
# ⁠ 11  13  4
# ⁠/  \    / \
# 7    2  5   1
#
# Return:
#
# [
# ⁠  [5,4,11,2],
# ⁠  [5,8,4,5]
# ]
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# DFS+Backtracking...

# @param {TreeNode} root
# @param {Integer} sum
# @return {Integer[][]}
def path_sum(root, sum, x=0, path=[], paths=[])
  return [] if root.nil?
  x += root.val
  path += [root.val]
  paths << path.dup if root.left.nil? && root.right.nil? && x == sum
  path_sum(root.left, sum, x, path, paths)
  path_sum(root.right, sum, x, path, paths)
  paths
end
