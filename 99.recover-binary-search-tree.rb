# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=99 lang=ruby
#
# [99] Recover Binary Search Tree
#
# https://leetcode.com/problems/recover-binary-search-tree/description/
#
# Two elements of a binary search tree (BST) are swapped by mistake.
#
# Recover the tree without changing its structure.
#
# Example 1:
#
# Input: [1,3,null,null,2]
# 1
# /
# 3
# \
# 2
# Output: [3,1,null,null,2]
# 3
# /
# 1
# \
# 2
#
# Example 2:
#
# Input: [3,1,4,null,null,2]
# ⁠ 3
# ⁠/ \
# 1   4
# /
# 2
# Output: [2,1,4,null,null,3]
# ⁠ 2
# ⁠/ \
# 1   4
# /
# ⁠ 3
#
#
# Follow up:
#
# A solution using O(n) space is pretty straight forward.
# Could you devise a constant space solution?
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# The key is in-order traversal.
#
#   1. Given correct BST, the in-order traversal array is sorted.
#   2. The 'mistake' happens when the current val is smaller than
#      previous val during in-order traversal.
#   3. Either there is only one mistake exists, meaning that we swap
#      two vals next to each other (in in-order array), or there are
#      two mistakes, meaning that we swap two nodes not next to each
#      other.
#
# E.g. Given [1,2,3,4,5]:
#
#    1. in-order is [1,3,2,4,5], [3,2] is a mistake, swap 3 and 2.
#    2. in-order is [1,4,3,2,5], [4,3] and [3,2] are the mistakes, swap 4 and 2.

# @param {TreeNode} root
# @return {Void} Do not return anything, modify root in-place instead.
def recover_tree(root)
  a, b = inorder(root)
  a.val, b.val = b.val, a.val
end

def inorder(node, prev=[], ans=[])
  return if node.nil?
  inorder(node.left, prev, ans)
  if !prev[0].nil? && prev[0].val > node.val
    if ans.size == 0
      ans << prev[0] << node
    else
      ans[1] = node
    end
  end
  prev[0] = node
  inorder(node.right, prev, ans)
  ans
end
