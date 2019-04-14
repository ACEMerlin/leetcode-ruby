# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1026 lang=ruby
#
# [1026] Maximum Difference Between Node and Ancestor
#
# https://leetcode.com/problems/maximum-difference-between-node-and-ancestor/description/
#
# Given the root of a binary tree, find the maximum value V for which
# there exists different nodes A and B where V = |A.val - B.val| and A
# is an ancestor of B.
#
# (A node A is an ancestor of B if either: any child of A is equal to B, or any
# child of A is an ancestor of B.)
#
# Example 1:
#
# Input: [8,3,10,1,6,null,14,null,null,4,7,13]
# Output: 7
# Explanation:
# We have various ancestor-node differences, some of which are given below :
# |8 - 3| = 5
# |3 - 7| = 4
# |8 - 1| = 7
# |10 - 13| = 3
# Among all possible differences, the maximum value of 7 is obtained by |8 - 1|
# = 7.
#
# Note:
#
# The number of nodes in the tree is between 2 and 5000.
# Each node will have value between 0 and 100000.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# Bottom up.

# @param {TreeNode} root
# @return {Integer}
def max_ancestor_diff(root)
  [-Float::INFINITY].tap { |r| helper(root, r) }
end

def helper(root, ans)
  return [root.val, root.val] if root.left.nil? && root.right.nil?
  min1, max1 = helper(root.left, ans) if !root.left.nil?
  min2, max2 = helper(root.right, ans) if !root.right.nil?
  min, max = [min1, min2, max1, max2].minmax
  ans[0] = [ans[0], (root.val-min).abs, (root.val-max).abs].max
  [min, max, root.val].minmax
end
