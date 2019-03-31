# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=102 lang=ruby
#
# [102] Binary Tree Level Order Traversal
#
# https://leetcode.com/problems/binary-tree-level-order-traversal/description/
#
# Given a binary tree, return the level order traversal of its nodes'
# values. (ie, from left to right, level by level).
#
# For example:
# Given binary tree [3,9,20,null,null,15,7],
#
# ⁠   3
# ⁠  / \
# ⁠ 9  20
# ⁠   /  \
# ⁠  15   7
#
# return its level order traversal as:
#
# [
# ⁠ [3],
# ⁠ [9,20],
# ⁠ [15,7]
# ]
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# The key is how to process one level at a time: only process queue's
# size at a time.

# @param {TreeNode} root
# @return {Integer[][]}
def level_order(root)
  return [] if root.nil?
  result = []
  queue = [root]
  until queue.empty?
    sub = []
    queue.size.times do
      x = queue.shift
      sub << x.val
      queue << x.left unless x.left.nil?
      queue << x.right unless x.right.nil?
    end
    result << sub
  end
  result
end
