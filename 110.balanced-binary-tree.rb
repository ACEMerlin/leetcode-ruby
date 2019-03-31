# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=110 lang=ruby
#
# [110] Balanced Binary Tree
#
# https://leetcode.com/problems/balanced-binary-tree/description/
#
# Given a binary tree, determine if it is height-balanced.
#
# For this problem, a height-balanced binary tree is defined as:
#
# a binary tree in which the depth of the two subtrees of every node never
# differ by more than 1.
#
# Example 1:
#
# Given the following tree [3,9,20,null,null,15,7]:
#
# ⁠   3
# ⁠  / \
# ⁠ 9  20
# ⁠   /  \
# ⁠  15   7
#
# Return true.
#
# Example 2:
#
# Given the following tree [1,2,2,3,3,null,null,4,4]:
#
# ⁠      1
# ⁠     / \
# ⁠    2   2
# ⁠   / \
# ⁠  3   3
# ⁠ / \
# ⁠4   4
#
# Return false.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# See 104 for max_depth. This is the intuitive version, for each node
# check if its left and right subtree's max_depth defer within 1.

# @param {TreeNode} root
# @return {Boolean}
def is_balanced_a(root)
  return true if root.nil?
  (max_depth(root.left) - max_depth(root.right)).abs <= 1 &&
    is_balanced_a(root.left) && is_balanced_a(root.right)
end

def max_depth(root)
  return 0 if root.nil?
  1 + [max_depth(root.left), max_depth(root.right)].max
end


# As you can see, max_depth is called muliple times on the same node
# so let's reduce time by removing duplicate calculations.

def is_balanced(root)
  max_depth_with_checker(root) != :not_balanced
end

def max_depth_with_checker(root)
  return 0 if root.nil?
  lh, rh = max_depth_with_checker(root.left), max_depth_with_checker(root.right)
  return :not_balanced if lh == :not_balanced || rh == :not_balanced
  return :not_balanced if (lh - rh).abs > 1
  1 + [lh, rh].max
end
