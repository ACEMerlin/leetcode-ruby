# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=103 lang=ruby
#
# [103] Binary Tree Zigzag Level Order Traversal
#
# https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/description/
#
# Given a binary tree, return the zigzag level order traversal of its
# nodes' values. (ie, from left to right, then right to left for the
# next level and alternate between).
#
# For example:
# Given binary tree [3,9,20,null,null,15,7],
# ⁠   3
# ⁠  / \
# ⁠ 9  20
# ⁠   /  \
# ⁠  15   7
# return its zigzag level order traversal as:
# [
# ⁠ [3],
# ⁠ [20,9],
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


# Same old level order traversal.

# @param {TreeNode} root
# @return {Integer[][]}
def zigzag_level_order(root)
  return [] if root.nil?
  q, flip, ans = [root], false, []
  while !q.empty?
    sub = []
    m = flip ? :unshift : :<<
    q.size.times do
      x = q.shift
      sub.send(m, x.val)
      q << x.left if x.left
      q << x.right if x.right
    end
    flip = !flip
    ans << sub
  end
  ans
end
