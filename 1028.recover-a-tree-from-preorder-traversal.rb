# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1028 lang=ruby
#
# [1028] Recover a Tree From Preorder Traversal
#
# https://leetcode.com/problems/recover-a-tree-from-preorder-traversal/description/
#
# We run a preorder depth first search on the root of a binary tree.
#
# At each node in this traversal, we output D dashes (where D is the
# depth of this node), then we output the value of this node. (If the
# depth of a node is D, the depth of its immediate child is D+1. The
# depth of the root node is 0.)
#
# If a node has only one child, that child is guaranteed to be the left child.
#
# Given the output S of this traversal, recover the tree and return
# its root.
#
# Example 1:
#
# Input: "1-2--3--4-5--6--7"
# Output: [1,2,5,3,4,6,7]
#
# Example 2:
#
# Input: "1-2--3---4-5--6---7"
# Output: [1,2,5,3,null,6,null,4,null,7]
#
# Example 3:
#
# Input: "1-401--349---90--88"
# Output: [1,401,null,349,88,90]
#
# Note:
#
# The number of nodes in the original tree is between 1 and 1000.
# Each node will have a value between 1 and 10^9.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# We can keep an array of nodes P that:
#
#   1. P[i] is the node at depth i which we are recovering its sub trees on.
#   2. P[i] is the parent of P[i+1].
#   3. P is essentially the call stack of dfs: a path from root to leaf.
#   4. P[0] is the root, it never changes.
#   5. Whenever we encounter a new node, put it in P[i].

# @param {String} s
# @return {TreeNode}
def recover_from_preorder(s)
  parents = []
  s.scan(/-*\d+/).each do |m|
    d = m.count('-')
    v = m[d..-1].to_i
    if d == 0
      parents[0] = TreeNode.new(v)
      next
    end
    parents[d] = child = TreeNode.new(v)
    parent = parents[d-1]
    if parent.left.nil?
      parent.left = child
    else
      parent.right = child
    end
  end
  parents[0]
end


# Use a dummy node as root so that we don't have to check d == 0 each time.

def recover_from_preorder(s)
  parents = [TreeNode.new(nil)]
  s.scan(/-*\d+/).each do |m|
    d = m.count('-')
    v = m[d..-1].to_i
    parent = parents[d]
    child = parents[d+1] = TreeNode.new(v)
    if parent.left.nil?
      parent.left = child
    else
      parent.right = child
    end
  end
  parents[0].left
end
