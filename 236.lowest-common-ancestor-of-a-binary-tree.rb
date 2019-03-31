# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=236 lang=ruby
#
# [236] Lowest Common Ancestor of a Binary Tree
#
# https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/description/
#
# Given a binary tree, find the lowest common ancestor (LCA) of two
# given nodes in the tree.
# 
# According to the definition of LCA on Wikipedia: “The lowest common
# ancestor is defined between two nodes p and q as the lowest node in
# T that has both p and q as descendants (where we allow a node to be
# a descendant of itself).”
# 
# Given the following binary tree: root = [3,5,1,6,2,0,8,null,null,7,4]
# 
# Example 1:
# 
# Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
# Output: 3
# Explanation: The LCA of nodes 5 and 1 is 3.
# 
# Example 2:
# 
# Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
# Output: 5
# Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a
# descendant of itself according to the LCA definition.
# 
# Note: All of the nodes' values will be unique. p and q are different
# and both values will exist in the binary tree.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# This problem troubles me for quite some time, at first I thought of
# using dfs to get the two paths from root to p and q, and diff on the
# paths to get the LCA, but it turns out to be quite simple, because
# the question guarantees that the nodes(p and q) exists:
#
#   1. If current node equals p or q, return it.
#   2. Else p and q maybe are inside left or right sub tree, search it.
#   3. If search result from left and right sub tree both are not nil, return root.
#   4. Otherwise return left or right sub tree, (return nil if both
#      are nil, or return the one that's not nil).

# @param {TreeNode} root
# @param {TreeNode} p
# @param {TreeNode} q
# @return {TreeNode}
def lowest_common_ancestor(root, p, q)
  return root if root.nil? || root == p || root == q
  left = lowest_common_ancestor(root.left, p, q)
  right = lowest_common_ancestor(root.right, p, q)
  return root if !left.nil? && !right.nil?
  left || right
end
