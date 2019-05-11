# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=124 lang=ruby
#
# [124] Binary Tree Maximum Path Sum
#
# https://leetcode.com/problems/binary-tree-maximum-path-sum/description/
#
# Given a non-empty binary tree, find the maximum path sum.
#
# For this problem, a path is defined as any sequence of nodes from
# some starting node to any node in the tree along the parent-child
# connections. The path must contain at least one node and does not
# need to go through the root.
#
# Example 1:
#
# Input: [1,2,3]
# ⁠      1
# ⁠     / \
# ⁠    2   3
# Output: 6
#
# Example 2:
#
# Input: [-10,9,20,null,null,15,7]
# -10
# / \
# 9  20
# /  \
#15   7
#
# Output: 42
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# @param {TreeNode} root
# @return {Integer}
def max_path_sum(root)
  [-Float::INFINITY].tap { |ans| helper(root, ans) }[0]
end

def helper(root, ans)
  return 0 if root.nil?
  l = [helper(root.left, ans), 0].max
  r = [helper(root.right, ans), 0].max
  ans[0] = [ans[0], root.val+l+r].max
  [root.val+l, root.val+r].max
end
