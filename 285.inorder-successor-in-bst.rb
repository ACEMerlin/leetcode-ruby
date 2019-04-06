# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=162 lang=ruby
#
# [162] Find Peak Element
#
# https://leetcode.com/problems/inorder-successor-in-bst/description/
#
# Given a binary search tree and a node in it, find the in-order
# successor of that node in the BST.
#
# Note: If the given node has no in-order successor in the tree,
# return null.


# See 'ceil' method in data-structures/treap.rb, it's the same except
# it doesn't return itself.

def inorder_successor(root, p)
  return if root.nil? || p.nil?
  if p.val >= root.val
    inorder_successor(root.right, p)
  else
    inorder_successor(root.left, p) || root
  end
end
