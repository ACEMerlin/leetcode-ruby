# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=5017 lang=ruby
#
# [5017] Sum of Root To Leaf Binary Numbers
#
# https://leetcode.com/problems/sum-of-root-to-leaf-binary-numbers/description/
#
# Given a binary tree, each node has value 0 or 1. Each root-to-leaf
# path represents a binary number starting with the most significant
# bit. For example, if the path is 0 -> 1 -> 1 -> 0 -> 1, then this
# could represent 01101 in binary, which is 13.
#
# For all leaves in the tree, consider the numbers represented by the
# path from the root to that leaf.
#
# Return the sum of these numbers modulo 10^9 + 7.
#
# Example 1:
#
# Input: [1,0,1,0,1,0,1]
# Output: 22
# Explanation: (100) + (101) + (110) + (111) = 4 + 5 + 6 + 7 = 22
#
# Note:
#
# The number of nodes in the tree is between 1 and 1000.
# node.val is 0 or 1.
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
# @return {Integer}
def sum_root_to_leaf(root, v=0)
  return 0 if root.nil?
  v = v*2 + root.val
  return v if root.left.nil? && root.right.nil?
  (sum_root_to_leaf(root.left, v) + sum_root_to_leaf(root.right, v)) % (10**9 + 7)
end
