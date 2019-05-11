# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=116 lang=ruby
#
# [116] Populating Next Right Pointers in Each Node
#
# https://leetcode.com/problems/populating-next-right-pointers-in-each-node/description/
#
# You are given a perfect binary tree where all leaves are on the same
# level, and every parent has two children. The binary tree has the
# following definition:
#
# class TreeNode
#     attr_accessor :val, :left, :right, :next
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil, nil
#     end
# end
#
# Populate each next pointer to point to its next right node. If there
# is no next right node, the next pointer should be set to NULL.
#
# Initially, all next pointers are set to NULL.

def connect(root)
  return if root.nil?
  if root.left
    root.left.next = root.right
    root.right.next = root.next.left if root.next
  end
  connect(root.left)
  connect(root.right)
  root
end
