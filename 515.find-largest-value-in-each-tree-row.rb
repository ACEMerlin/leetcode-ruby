# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=515 lang=ruby
#
# [515] Find Largest Value in Each Tree Row
#
# https://leetcode.com/problems/find-largest-value-in-each-tree-row/description/
#
# You need to find the largest value in each row of a binary tree.
#
# Example:
#
# Input:
# ⁠         1
# ⁠        / \
# ⁠       3   2
# ⁠      / \   \
# ⁠     5   3   9
# Output: [1, 3, 9]
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# See problem 102.

# @param {TreeNode} root
# @return {Integer[]}
def largest_values(root)
  return [] if root.nil?
  q, ans = [root], []
  while !q.empty?
    max = -Float::INFINITY
    q.size.times do
      x = q.shift
      max = [max, x.val].max
      q << x.left unless x.left.nil?
      q << x.right unless x.right.nil?
    end
    ans << max
  end
  ans
end
