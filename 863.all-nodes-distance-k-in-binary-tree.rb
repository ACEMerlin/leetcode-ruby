# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=863 lang=ruby
#
# [863] All Nodes Distance K in Binary Tree
#
# https://leetcode.com/problems/all-nodes-distance-k-in-binary-tree/description/
#
# We are given a binary tree (with root node root), a target node, and
# an integer value K.
#
# Return a list of the values of all nodes that have a distance K from the
# target node. The answer can be returned in any order.
#
# Example 1:
#
# Input: root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, K = 2
# Output: [7,4,1]
# Explanation:
# The nodes that are a distance 2 from the target node (with value 5)
# have values 7, 4, and 1.
#
# Note that the inputs "root" and "target" are actually TreeNodes.
# The descriptions of the inputs above are just serializations of these
# objects.
#
# Note:
#
# The given tree is non-empty.
# Each node in the tree has unique values 0 <= node.val <= 500.
# The target node is a node in the tree.
# 0 <= K <= 1000.
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# It feels more like a graph problem than a tree problem:
#
#   1. Convert the tree into a undirected graph.
#   2. Use normal dfs to search the graph until distance is bigger than k.
#
# Example, given tree:
#               3
#             /   \
#            5     1
#           / \   / \
#          6   2 0   8
#             / \
#            7   4
#
# After step 1 (a hash {node:neighbors}):
# { 6=>[5],
#   5=>[6, 2, 3],
#   7=>[2],
#   2=>[7, 4, 5],
#   4=>[2],
#   3=>[5, 1],
#   0=>[1],
#   1=>[0, 8, 3],
#   8=>[1] }

# @param {TreeNode} root
# @param {TreeNode} target
# @param {Integer} k
# @return {Integer[]}
def distance_k(root, target, k)
  dfs(to_graph(root), target.val, k)
end

def to_graph(x, graph=Hash.new{ |h, k| h[k] = [] })
  [x.left, x.right].compact.each do |t|
    to_graph(t, graph)
    graph[t.val] << x.val
    graph[x.val] << t.val
  end
  graph
end

def dfs(graph, start, k, dist=0, marked=Set.new, result=[])
  return if dist > k
  result << start if dist == k
  marked << start
  graph[start].each do |n|
    if !marked.include?(n)
      dfs(graph, n, k, dist+1, marked, result)
    end
  end
  result
end
