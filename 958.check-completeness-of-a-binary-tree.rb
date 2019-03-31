# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=958 lang=ruby
#
# [958] Check Completeness of a Binary Tree
#
# https://leetcode.com/problems/check-completeness-of-a-binary-tree/description/
#
# Given a binary tree, determine if it is a complete binary tree.
#
# Definition of a complete binary tree from Wikipedia: In a complete
# binary tree every level, except possibly the last, is completely
# filled, and all nodes in the last level are as far left as possible.
# It can have between 1 and 2h nodes inclusive at the last level h.
#
# Example 1:
#
# Input: [1,2,3,4,5,6]
# Output: true
# Explanation: Every level before the last is full (ie. levels with node-values
# {1} and {2, 3}), and all nodes in the last level ({4, 5, 6}) are as far left
# as possible.
#
# Example 2:
#
# Input: [1,2,3,4,5,null,7]
# Output: false
# Explanation: The node with value 7 isn't as far left as possible.
#
# Note:
#
# The tree will have between 1 and 100 nodes.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# The key is lever-order traversal and check the occurence of nil.
#
# Example:
#       1
#      / \
#     2   3
#    / \
#   4   5
#  / \
# 8   9
#
# q                         node    t
# [1]                       1       f
# [2,3]                     2       f
# [3,4,5]                   3       f
# [4,5,nil,nil]             4       f
# [5,nil,nil,8,9]           5       f
# [nil,nil,8,9,nil,nil]     nil     t
# [nil,8,9,nil,nil]         nil     t
# [8,9,nil,nil]             8       t && 8 return false

# @param {TreeNode} root
# @return {Boolean}
def is_complete_tree(root)
  q = [root]
  t = false
  until q.empty?
    node = q.shift
    t = true and next if node.nil?
    return false if t
    q << node.left
    q << node.right
  end
  true
end
