# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=230 lang=ruby
#
# [230] Kth Smallest Element in a BST
#
# https://leetcode.com/problems/kth-smallest-element-in-a-bst/description/
#
# Given a binary search tree, write a function kthSmallest to find the
# kth smallest element in it.
#
# Note: You may assume k is always valid, 1 ≤ k ≤ BST's total elements.
#
# Example 1:
#
# Input: root = [3,1,4,null,2], k = 1
# ⁠  3
# ⁠ / \
# ⁠1   4
# ⁠ \
# 2
# Output: 1
#
# Example 2:
#
# Input: root = [5,3,6,2,4,null,null,1], k = 3
# ⁠      5
# ⁠     / \
# ⁠    3   6
# ⁠   / \
# ⁠  2   4
# ⁠ /
# ⁠1
#
# Output: 3
#
# Follow up: What if the BST is modified (insert/delete operations)
# often and you need to find the kth smallest frequently? How would
# you optimize the kthSmallest routine?
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# See problem 94, the core idea is in-order traversal, stop at the kth element.

# Iterative version:

# @param {TreeNode} root
# @param {Integer} k
# @return {Integer}
def kth_smallest_a(root, k)
  count = 0
  stack = [root]
  while true
    top = stack[-1]
    if !top&.left.nil?
      stack << top.left
    else
      t = stack.pop
      t = stack.pop if t.nil?
      break if t.nil?
      count += 1
      return t.val if count == k
      stack << t.right
    end
  end
end


# Recursive version

def kth_smallest(root, k, count=[0])
  return if root.nil?
  kth_smallest(root.left, k, count) ||
    checker(root, k, count) ||
    kth_smallest(root.right, k, count)
end

def checker(root, k, count)
  count[0] += 1
  return root.val if count[0] == k
end
