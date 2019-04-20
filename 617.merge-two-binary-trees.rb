# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=617 lang=ruby
#
# [617] Merge Two Binary Trees
#
# https://leetcode.com/problems/merge-two-binary-trees/description/
#
# Given two binary trees and imagine that when you put one of them to
# cover the other, some nodes of the two trees are overlapped while
# the others are not.
#
# You need to merge them into a new binary tree. The merge rule is
# that if two nodes overlap, then sum node values up as the new value
# of the merged node. Otherwise, the NOT null node will be used as the
# node of new tree.
#
# Example 1:
#
# Input:
# Tree 1                     Tree 2
# ⁠         1                         2
# ⁠        / \                       / \
# ⁠       3   2                     1   3
# ⁠      /                           \   \
# ⁠     5                             4   7
# Output:
# Merged tree:
# 3
# / \
# 4   5
# / \   \
# 5   4   7
#
# Note: The merging process must start from the root nodes of both trees.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# @param {TreeNode} t1
# @param {TreeNode} t2
# @return {TreeNode}
def merge_trees(t1, t2)
  return t1 if t2.nil?
  return t2 if t1.nil?
  x = TreeNode.new(t1.val+t2.val)
  x.left = merge_trees(t1.left, t2.left)
  x.right = merge_trees(t1.right, t2.right)
  x
end
