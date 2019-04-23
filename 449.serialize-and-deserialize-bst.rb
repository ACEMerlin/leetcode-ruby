# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=449 lang=ruby
#
# [449] Serialize and Deserialize BST
#
# https://leetcode.com/problems/serialize-and-deserialize-bst/description/
#
# Serialization is the process of converting a data structure or
# object into a sequence of bits so that it can be stored in a file or
# memory buffer, or transmitted across a network connection link to be
# reconstructed later in the same or another computer environment.
#
# Design an algorithm to serialize and deserialize a binary search tree. There
# is no restriction on how your serialization/deserialization algorithm should
# work. You just need to ensure that a binary search tree can be serialized to
# a string and this string can be deserialized to the original tree structure.
#
# The encoded string should be as compact as possible.
#
# Note: Do not use class member/global/static variables to store states. Your
# serialize and deserialize algorithms should be stateless.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# See problem 297, 105.

# Encodes a tree to a single string.
#
# @param {TreeNode} root
# @return {string}
def serialize(root, s="")
  return s if root.nil?
  s << "#{root.val},"
  serialize(root.left, s)
  serialize(root.right, s)
  s
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}
def deserialize(data)
  preorder = data.split(',').map(&:to_i)
  inorder = preorder.sort
  h = inorder.zip(inorder.size.times).to_h
  rec = ->(lo, hi) {
    return if lo > hi
    x = TreeNode.new(preorder.shift)
    m = h[x.val]
    x.left = rec[lo, m-1]
    x.right = rec[m+1, hi]
  }
  rec[0, inorder.size-1]
end
