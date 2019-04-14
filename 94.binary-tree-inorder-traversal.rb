# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=94 lang=ruby
#
# [94] Binary Tree Inorder Traversal
#
# https://leetcode.com/problems/binary-tree-inorder-traversal/description/
#
# Given a binary tree, return the inorder traversal of its nodes' values.
#
# Example:
#
# Input: [1,null,2,3]
# ⁠  1
# ⁠   \
# ⁠    2
# ⁠   /
# ⁠  3
# Output: [1,3,2]
#
# Follow up: Recursive solution is trivial, could you do it iteratively?
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end



# @param {TreeNode} root
# @return {Integer[]}
def inorder_traversal(root, ans=[])
  return [] if root.nil?
  inorder_traversal(root.left, ans)
  ans << root.val
  inorder_traversal(root.right, ans)
  ans
end


# given:
#     3
#    / \
#   1   4
#  / \
# 0   2

#calls      in-order     stack     english
#3,a        []           3         3 has left, push 1
#  1,a      []           3,1       1 has left, push 0
#    0,a    []           3,1,0     0 has no left
#      a<<0 [0]          3,1,nil   pop, it's 0, print 0, push 0's right
#    a<<1   [0,1]        3,2       pop, it's nil, pop again, it's 1, print 1, push 1's right
#    2,a    [0,1]        3,2       2 has no left
#      a<<2 [0,1,2]      3,nil     pop, it's 2, pirnt 2, push 2's right
#  a<<3     [0,1,2,3]    4         pop, it's nil, pop again, it's 3, print 3, push 3's right
#  4,a      [0,1,2,3]    4         4 has no left
#    a<<4   [0,1,2,3,4]  nil       pop, it's 4, print 4, push 4's right
#                        []        pop, it's nil, pop again, it's nil, break

def inorder_traversal_a(root)
  ret = []
  stack = [root]
  while true
    top = stack[-1]
    if !top&.left.nil?
      stack << top.left
    else
      t = stack.pop
      t = stack.pop if t.nil?
      break if t.nil?
      ret << t.val
      stack << t.right
    end
  end
  ret
end


# https://en.wikipedia.org/wiki/Tree_traversal#In-order

def inorder_traversal_b(root)
  stack, ans = [], []
  while !stack.empty? || !root.nil?
    if !root.nil?
      stack << root
      root = root.left
    else
      root = stack.pop
      ans << root.val
      root = root.right
    end
  end
  ans
end
