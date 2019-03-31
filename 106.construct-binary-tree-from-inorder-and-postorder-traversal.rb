# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=106 lang=ruby
#
# [106] Construct Binary Tree from Inorder and Postorder Traversal
#
# https://leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/description/
#
# Given inorder and postorder traversal of a tree, construct the
# binary tree.
#
# Note: You may assume that duplicates do not exist in the tree.
#
# For example, given
#
# inorder = [9,3,15,20,7]
# postorder = [9,15,7,20,3]
#
# Return the following binary tree:
#
# ⁠   3
# ⁠  / \
# ⁠ 9  20
# ⁠   /  \
# ⁠  15   7
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# See problem 105, it's the same idea.
#
# Postorder: [left, right, root]
# Inorder  : [left, root, right]

# @param {Integer[]} inorder
# @param {Integer[]} postorder
# @return {TreeNode}
def build_tree_a(inorder, postorder)
  return [] if inorder.empty?
  helper(postorder, inorder)
end

def helper(postorder, inorder)
  return if postorder.nil? || postorder.empty?
  root_index = inorder.index(postorder.pop)
  root = TreeNode.new(inorder[root_index])
  left = inorder[0...root_index]
  root.left = helper(postorder[0, left.length], left)
  right = inorder[(root_index+1)..-1]
  root.right = helper(postorder[left.length, right.length], right)
  root
end


# Optimized version

def build_tree(inorder, postorder)
  return [] if inorder.empty?
  memo = inorder.zip(inorder.size.times).to_h
  recur = ->(lo, hi) {
    return if lo > hi
    root = TreeNode.new(postorder.pop)
    mid = memo[root.val]
    root.right = recur[mid+1, hi]
    root.left = recur[lo, mid-1]
    root
  }
  recur[0, inorder.length-1]
end
