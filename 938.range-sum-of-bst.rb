# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=938 lang=ruby
#
# [938] Range Sum of BST
#
# https://leetcode.com/problems/range-sum-of-bst/description/
#
# Given the root node of a binary search tree, return the sum of
# values of all nodes with value between L and R (inclusive).
#
# The binary search tree is guaranteed to have unique values.
#
# Example 1:
#
# Input: root = [10,5,15,3,7,null,18], L = 7, R = 15
# Output: 32
#
# Example 2:
#
# Input: root = [10,5,15,3,7,13,18,1,null,6], L = 6, R = 10
# Output: 23
#
# Note:
#
# The number of nodes in the tree is at most 10000.
# The final answer is guaranteed to be less than 2^31.
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
# @param {Integer} l
# @param {Integer} r
# @return {Integer}
def range_sum_bst(root, l, r, sum = 0)
  return 0 if root.nil?
  return range_sum_bst(root.right, l, r, sum) if root.val < l
  return range_sum_bst(root.left, l, r, sum) if root.val > r
  range_sum_bst(root.left, l, r, sum) + root.val + range_sum_bst(root.right, l, r, sum)
end
