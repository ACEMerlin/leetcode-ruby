# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=337 lang=ruby
#
# [337] House Robber III
#
# https://leetcode.com/problems/house-robber-iii/description/
#
# The thief has found himself a new place for his thievery again.
# There is only one entrance to this area, called the "root." Besides
# the root, each house has one and only one parent house. After a
# tour, the smart thief realized that "all houses in this place forms
# a binary tree". It will automatically contact the police if two
# directly-linked houses were broken into on the same night.
#
# Determine the maximum amount of money the thief can rob tonight
# without alerting the police.
#
# Example 1:
#
# Input: [3,2,3,null,3,null,1]
# ⁠    3
# ⁠   / \
# ⁠  2   3
# ⁠   \   \
# ⁠    3   1
# Output: 7
# Explanation: Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
#
# Example 2:
#
# Input: [3,4,5,1,3,null,1]
#     3
# ⁠   / \
# ⁠  4   5
# ⁠ / \   \
# ⁠1   3   1
# Output: 9
# Explanation: Maximum amount of money the thief can rob = 4 + 5 = 9.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# Top down recursion with memorization.

# @param {TreeNode} root
# @return {Integer}
def rob(root, memo={})
  return 0 if root.nil?
  return memo[root] if memo.has_key?(root)
  v = root.val
  v += rob(root.left.left, memo) + rob(root.left.right, memo) if root.left
  v += rob(root.right.left, memo) + rob(root.right.right, memo) if root.right
  [v, rob(root.left, memo)+rob(root.right, memo)].max.tap { |x| memo[root] = x }
end


# DFS, can't quite wrap me head around this.

def rob_a(root)
  sub_rob(root)[0]
end

def sub_rob(root)
  return [0, 0, 0] if root.nil?
  l, ll, lr = sub_rob(root.left)
  r, rl, rr = sub_rob(root.right)
  [[l+r, root.val+ll+lr+rl+rr].max, l, r]
end
