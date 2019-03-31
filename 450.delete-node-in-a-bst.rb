# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=450 lang=ruby
#
# [450] Delete Node in a BST
#
# https://leetcode.com/problems/delete-node-in-a-bst/description/
#
# Given a root node reference of a BST and a key, delete the node with
# the given key in the BST. Return the root node reference (possibly
# updated) of the BST.
#
# Basically, the deletion can be divided into two stages:
#
# Search for a node to remove.
# If the node is found, delete the node.
#
# Note: Time complexity should be O(height of tree).
#
# Example:
#
# root = [5,3,6,2,4,null,7]
# key = 3
#
# ⁠   5
# ⁠  / \
# ⁠ 3   6
# ⁠/ \   \
# 2   4   7
#
# Given key to delete is 3. So we find the node with value 3 and delete it.
#
# One valid answer is [5,4,6,2,null,null,7], shown in the following BST.
#
# ⁠   5
# ⁠  / \
# ⁠ 4   6
# ⁠/     \
# 2       7
#
# Another valid answer is [5,2,6,null,4,null,7].
#
# ⁠   5
# ⁠  / \
# ⁠ 2   6
# ⁠  \   \
# ⁠   4   7
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# Let's first consider a simpler problem: How to delete the minimum
# node: 1. Go left until finding a node with a null left link. 2.
# replace that node by it's right link.

def delete_min(root)
  return root.right if root.left.nil?
  root.left = delete_min(root.left)
  root
end

# To delete a node with no children, just replace it with nil
# To delete a node with one children, just replace it with its children
# To delete a node with two children:
#   1. Find successor x of t.
#   2. Delete the minimum t's right subtree.
#   3. Put x in t's spot.

def find_min(root)
  return root if root.nil? || root.left.nil?
  find_min(root.left)
end

# @param {TreeNode} root
# @param {Integer} key
# @return {TreeNode}
def delete_node(root, key)
  return if root.nil?
  cmp = key <=> root.val
  if cmp < 0
    root.left = delete_node(root.left, key)
  elsif cmp > 0
    root.right = delete_node(root.right, key)
  else
    # no children or one children
    return root.left if root.right.nil?
    return root.right if root.left.nil?
    # two children
    old_root = root
    root = find_min(old_root.right)
    root.right = delete_min(old_root.right)
    root.left = old_root.left
  end
  root
end
