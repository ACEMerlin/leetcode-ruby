# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=783 lang=ruby
#
# [783] Minimum Distance Between BST Nodes
#
# https://leetcode.com/problems/minimum-distance-between-bst-nodes/description/
#
# Given a Binary Search Tree (BST) with the root node root, return the
# minimum difference between the values of any two different nodes in
# the tree.
#
# Example :
#
# Input: root = [4,2,6,1,3,null,null]
# Output: 1
# Explanation:
# Note that root is a TreeNode object, not an array.
#
# The given tree [4,2,6,1,3,null,null] is represented by the following
# diagram:
#
# ⁠         4
# ⁠       /   \
# ⁠     2      6
# ⁠    / \
# ⁠   1   3
#
# while the minimum difference in this tree is 1, it occurs between node 1 and
# node 2, also between node 3 and node 2.
#
# Note:
#
# The size of the BST will be between 2 and 100.
# The BST is always valid, each node's value is an integer, and each node's
# value is different.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# The core idea is inorder traversal:
#
#   1. Inorder traversal a bst result in an ordered list.
#   2. Keep record of the previous visited node.
#   3. Update mininal distance if current node.val-previous is smaller.

# @param {TreeNode} root
# @return {Integer}
def min_diff_in_bst(root, prev=[], min=[Float::INFINITY])
  return if root.nil?
  min_diff_in_bst(root.left, prev, min)
  min[0] = [min[0], root.val-prev[0]].min if prev[0]
  prev[0] = root.val
  min_diff_in_bst(root.right, prev, min)
  min[0]
end
