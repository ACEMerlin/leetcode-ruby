# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=297 lang=ruby
#
# [297] Serialize and Deserialize Binary Tree
#
# https://leetcode.com/problems/serialize-and-deserialize-binary-tree/description/

# Serialization is the process of converting a data structure or
# object into a sequence of bits so that it can be stored in a file or
# memory buffer, or transmitted across a network connection link to be
# reconstructed later in the same or another computer environment.
#
# Design an algorithm to serialize and deserialize a binary tree.
# There is no restriction on how your serialization/deserialization
# algorithm should work. You just need to ensure that a binary tree
# can be serialized to a string and this string can be deserialized to
# the original tree structure.
#
# Example:
#
# You may serialize the following tree:
#
# ⁠   1
# ⁠  / \
# ⁠ 2   3
# ⁠    / \
# ⁠   4   5
#
# as "[1,2,3,null,null,4,5]"
#
#
# Clarification: The above format is the same as how LeetCode
# serializes a binary tree. You do not necessarily need to follow this
# format, so please be creative and come up with different approaches
# yourself.
#
# Note: Do not use class member/global/static variables to store
# states. Your serialize and deserialize algorithms should be
# stateless.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# This is the iterative BFS version, pretty straight forword. Mind
# that root could be nil.
#
#   1. serialize: using level order traversal, the 'N's at the end doesn't matter.
#   2. deserialize: the trick is to keep a queue of current node we are building.
#
# Given tree:
#               3
#             /   \
#            5     1
#           / \   / \
#          6   2 0   8
#             / \
#            7   4
#
# serialize => "3,5,1,6,2,0,8,N,N,7,4,N,N,N,N,N,N,N,N"

# Encodes a tree to a single string.
#
# @param {TreeNode} root
# @return {string}
def serialize_a(root)
  q = [root]
  ret = []
  until q.empty?
    cur = q.shift
    ret << cur&.val
    next if cur.nil?
    q << cur.left
    q << cur.right
  end
  ret.map { |v| v.nil? ? 'N' : v }.join(",")
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}
def deserialize_a(data)
  data = data.split(",").map { |v| v == 'N' ? nil : v }
  first = data.shift
  return nil if first.nil?
  root = TreeNode.new(first)
  q = [root]
  until q.empty?
    cur = q.shift
    left = data.shift
    unless left.nil?
      cur.left = TreeNode.new(left)
      q << cur.left
    end
    right = data.shift
    unless right.nil?
      cur.right= TreeNode.new(right)
      q << cur.right
    end
  end
  root
end


# This is the recursive DFS version, stolen from leetcode discussion.
# If you have problem with the deserialize process, see problem 105.
#
#   1. serialize, using preorder traversal (root, left, right).
#   2. deserialize, build tree using preorder traversal.
#
# Given tree:
#               3
#             /   \
#            5     1
#           / \   / \
#          6   2 0   8
#             / \
#            7   4
#
# serialize => "3,5,6,N,N,2,7,N,N,4,N,N,1,0,N,N,8,N,N,"

def serialize(root, str='')
  if root.nil?
    str << "N,"
  else
    str << root.val << ","
    serialize(root.left, str)
    serialize(root.right, str)
  end
  str
end

def deserialize(data)
  data = data.split(",")
  rec = -> {
    first = data.shift
    return if first == 'N'
    root = TreeNode.new(first)
    root.left = rec.call
    root.right = rec.call
    root
  }
  rec.call
end
