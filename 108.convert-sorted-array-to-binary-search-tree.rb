# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=108 lang=ruby
#
# [108] Convert Sorted Array to Binary Search Tree
#
# https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/description/
#
# Given an array where elements are sorted in ascending order, convert
# it to a height balanced BST.
#
# For this problem, a height-balanced binary tree is defined as a
# binary tree in which the depth of the two subtrees of every node
# never differ by more than 1.
#
# Example:
#
# Given the sorted array: [-10,-3,0,5,9],
#
# One possible answer is: [0,-3,9,-10,null,5], which represents the following
# height balanced BST:
#
# ⁠     0
# ⁠    / \
# ⁠  -3   9
# ⁠  /   /
# ⁠-10  5
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# The idea is simple, pick mid element as root and recursively call on
# left side and right right.
#
# Egde case:
#   - Only 1 element on one side, simply pick that as left/right.
#   - Length of array is even, if mid==(left+right)/2 then pick mid or mid-1.
#
# e.g. given [-10, -3, 0, 5, 9, 10]
#
# pick mid (6/2=>3)  /   mid-1
#        5                 0
#       / \               / \
#      -3  10           -10  9
#     / \   /            \   /\
#   -10  0  9            -3 5  10
#
# both by defination are correct

# @param {Integer[]} nums
# @return {TreeNode}
def sorted_array_to_bst(nums, lo = 0, hi = nums.length-1)
  return if lo > hi
  mid = (lo + hi + 1) / 2
  TreeNode.new(nums[mid]).tap do |root|
    root.left = sorted_array_to_bst(nums, lo, mid-1)
    root.right = sorted_array_to_bst(nums, mid+1, hi)
  end
end
