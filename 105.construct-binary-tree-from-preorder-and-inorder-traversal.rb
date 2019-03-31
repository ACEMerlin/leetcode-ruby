# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=105 lang=ruby
#
# [105] Construct Binary Tree from Preorder and Inorder Traversal
#
# https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/
#
# Given preorder and inorder traversal of a tree, construct the binary
# tree.
#
# Note: You may assume that duplicates do not exist in the tree.
#
# For example, given
#
# preorder = [3,9,20,15,7]
# inorder = [9,3,15,20,7]
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


# Preorder: [root, left, right]
# Inoredr : [left, root, right]
# So the idea is simple:
#
#   1. Pop the first element of preorder and use it as root.
#   2. Search the root in inoder (speed can optimized by using a hashmap).
#   3. Split inorder by it, get left slice and right slice.
#   4. Split preorder into two parts as large as the size of previous left slice and right slice.
#   5. root.left = build_tree(preorder's left slice, inorder's left slice).
#   6. root.right = build_tree(preorder's right slice, inorder's right slice).
#   7. Done, return root.

# @param {Integer[]} preorder
# @param {Integer[]} inorder
# @return {TreeNode}
def build_tree_a(preorder, inorder)
  return [] if inorder.empty?
  helper(preorder, inorder)
end

def helper(preorder, inorder)
  return if preorder.nil? || preorder.empty?
  root_index = inorder.index(preorder.shift)
  root = TreeNode.new(inorder[root_index])
  left = inorder[0...root_index]
  root.left = helper(preorder[0, left.length], left)
  right = inorder[(root_index+1)..-1]
  root.right = helper(preorder[left.length, right.length], right)
  root
end


# The above method involes many array slicing and many O(n) find
# operations, which are slow. Let's observe above helper function:
#
# 1. We actually use only preorder to construct our tree(preorder.shift)
# 2. After the first recursive call to build the left sub tree we
#    have poped 'left.length' elements from preorder, if we haven't touched
#    preorder, the rest of it would be all in the right sub tree, and the
#    next element in preorder would be the root of the right sub tree.
#    and it's true for all recursive calls.
# 3. So as you can see, the slicing only serve as a count of how many shift
#    operations we have worked on preorder, we can avoid that by marking the
#    indices of current sub tree we are working on.
# 4. If the indices overlap it means that this sub tree is nil.
#
# See problem 297 for how to build a tree using preorder traversal.

def build_tree(preorder, inorder)
  return [] if inorder.empty?
  memo = inorder.zip(inorder.size.times).to_h
  recur = ->(lo, hi) {
    return if lo > hi
    root = TreeNode.new(preorder.shift)
    mid = memo[root.val]
    root.left = recur[lo, mid-1]
    root.right = recur[mid+1, hi]
    root
  }
  recur[0, inorder.length-1]
end
