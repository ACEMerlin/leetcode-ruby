# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=98 lang=ruby
#
# [98] Validate Binary Search Tree
#
# https://leetcode.com/problems/validate-binary-search-tree/description/
#
# Given a binary tree, determine if it is a valid binary search tree (BST).
#
# Assume a BST is defined as follows:
#
# The left subtree of a node contains only nodes with keys less than
# the node's key. The right subtree of a node contains only nodes with
# keys greater than the node's key. Both the left and right subtrees
# must also be binary search trees.
#
# Example 1:
#
# Input:
# ⁠   2
# ⁠  / \
# ⁠ 1   3
# Output: true
#
# Example 2:
#
# Input:
# ⁠   5
# ⁠  / \
# ⁠ 1   4
# / \
# 3   6
# Output: false
# Explanation: The input is: [5,1,4,null,null,3,6]. The root node's
# value
# is 5 but its right child's value is 4.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# In-order traversal the tree and check if it's sorted

# @param {TreeNode} root
# @return {Boolean}
def is_valid_bst_a(root)
  inorder_traversal(root).each_cons(2).all? { |p, q| (p <=> q) < 0 }
end

def inorder_traversal(root)
  [].tap { |s| helper_a(root, s) }
end

def helper_a(root, a)
  return if root.nil?
  helper_a(root.left, a)
  a << root.val
  helper_a(root.right, a)
end


# Save space by checking only the current and previous node
# Ruby is call-by-value so we have to use a single element array to store previous
# Given:
#     3
#    / \
#   1   4
#  / \
# 0   2
#
#calls      in-order    previous
#3,a        []          []
#  1,a      []          []
#    0,a    []          []
#      a<<0 [0]         [0]  (*special*)
#    a<<1   [0,1]       [1]  (0 < 1)
#    2,a    [0,1]       [1]
#      a<<2 [0,1,2]     [2]  (1 < 2)
#  a<<3     [0,1,2,3]   [3]  (2 < 3)
#  4,a      [0,1,2,3]   [3]
#    a<<4   [0,1,2,3,4] [4]  (3 < 4)

def is_valid_bst_b(root)
  helper_b(root)
end

def helper_b(root, prev=[])
  return true if root.nil?
  helper_b(root.left, prev) && checker_b(root, prev) && helper_b(root.right, prev)
end

def checker_b(node, prev)
  return false if !prev.empty? && node.val <= prev[0]
  prev[0] = node.val and return true
end


# Narrowing min,max for each node
# Given:
#                3(-inf,+inf)
#               / \
#      (-inf,3)1   4(3,+inf)
#             / \
#    (-inf,1)0   2(1,3)

def is_valid_bst(root)
  helper(root, -Float::INFINITY, Float::INFINITY)
end

def helper(node, low, hi)
  return true if node.nil?
  return false unless node.val > low && node.val < hi
  helper(node.left, low, node.val) && helper(node.right, node.val, hi)
end
