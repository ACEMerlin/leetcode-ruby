# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=104 lang=ruby
#
# [104] Maximum Depth of Binary Tree
#
# https://leetcode.com/problems/maximum-depth-of-binary-tree/description/
#
# Given a binary tree, find its maximum depth.
#
# The maximum depth is the number of nodes along the longest path from
# the root node down to the farthest leaf node.
#
# Note: A leaf is a node with no children.
#
# Example:
#
# Given binary tree [3,9,20,null,null,15,7],
#
# ⁠   3
# ⁠  / \
# ⁠ 9  20
# ⁠   /  \
# ⁠  15   7
#
# return its depth = 3.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# Iterative version.

# @param {TreeNode} root
# @return {Integer}
def max_depth_a(root)
  return 0 if root.nil?
  queue = [[root,1]]
  max = 1
  until queue.empty?
    cur, height = queue.shift
    queue << [cur.left, height+1] unless cur.left.nil?
    queue << [cur.right, height+1] unless cur.right.nil?
    max = [height+1, max].max if !cur.left.nil? || !cur.right.nil?
  end
  max
end


# Recursive version.

def max_depth_b(root)
  return 0 if root.nil?
  1 + [max_depth_b(root.left), max_depth_b(root.right)].max
end


# Another recursive version.

def max_depth(root, d = 1)
  return 0 if root.nil?
  return d unless root.left || root.right
  [max_depth(root.left, d+1), max_depth(root.right, d+1)].max
end

#       1
#      / \
#     2   4
#    /   / \
#   3   5   7
#        \
#         6
#          \
#           8
#
# max_depth(1, 1)
#   max_depth(2, 2)
#     max_depth(3, 3)
#     max_depth(nil, 3)
#   max_depth(4, 2)
#     max_depth(5, 3)
#       max_depth(nil, 4)
#       max_depth(6, 4)
#         max_depth(nil, 5)
#         max_depth(8, 5)
#     max_depth(7, 3)
