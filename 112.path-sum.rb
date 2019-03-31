# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=112 lang=ruby
#
# [112] Path Sum
#
# https://leetcode.com/problems/path-sum/description/
#
# Given a binary tree and a sum, determine if the tree has a
# root-to-leaf path such that adding up all the values along the path
# equals the given sum.
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
# ⁠/  \      \
# 7    2      1
#
# return true, as there exist a root-to-leaf path 5->4->11->2 which
# sum is 22.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# DFS...

# @param {TreeNode} root
# @param {Integer} sum
# @return {Boolean}
def has_path_sum(root, sum, x=0)
  return false if root.nil?
  x += root.val
  return true if root.left.nil? && root.right.nil? && x == sum
  has_path_sum(root.left, sum, x) || has_path_sum(root.right, sum, x)
end
