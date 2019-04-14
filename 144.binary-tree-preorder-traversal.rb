# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=144 lang=ruby
#
# [144] Binary Tree Preorder Traversal
#
# https://leetcode.com/problems/binary-tree-preorder-traversal/description/
#
# Given a binary tree, return the preorder traversal of its nodes' values.
#
# Example:
#
# Input: [1,null,2,3]
# ⁠  1
# ⁠   \
# ⁠    2
# ⁠   /
# ⁠  3
# Output: [1,2,3]
#
# Follow up: Recursive solution is trivial, could you do it iteratively?
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# Recursive.

# @param {TreeNode} root
# @return {Integer[]}
def preorder_traversal(root, ans=[])
  return [] if root.nil?
  ans << root.val
  preorder_traversal(root.left, ans)
  preorder_traversal(root.right, ans)
  ans
end


# Iterative.

def preorder_traversal_a(root)
  return [] if root.nil?
  stack, ans = [root], []
  while !stack.empty?
    x = stack.pop
    ans << x.val
    stack << x.right if !x.right.nil?
    stack << x.left if !x.left.nil?
  end
  ans
end
