# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=210 lang=ruby
#
# [210] Course Schedule II
#
# https://leetcode.com/problems/course-schedule-ii/description/
#
# There are a total of n courses you have to take, labeled from 0 to n-1.
#
# Some courses may have prerequisites, for example to take course 0
# you have to first take course 1, which is expressed as a pair: [0,1]
#
# Given the total number of courses and a list of prerequisite pairs, return
# the ordering of courses you should take to finish all courses.
#
# There may be multiple correct orders, you just need to return one of them. If
# it is impossible to finish all courses, return an empty array.
#
# Example 1:
#
# Input: 2, [[1,0]]
# Output: [0,1]
# Explanation: There are a total of 2 courses to take. To take course
# 1 you should have finished course 0. So the correct course order is
# [0,1] .
#
# Example 2:
#
# Input: 4, [[1,0],[2,0],[3,1],[3,2]]
# Output: [0,1,2,3] or [0,2,1,3]
# Explanation: There are a total of 4 courses to take. To take course
# 3 you should have finished both ⁠ courses 1 and 2. Both courses 1 and
# 2 should be taken after you finished course 0. So one correct course
# order is [0,1,2,3]. Another correct ordering is [0,2,1,3] .
#
# Note:
#
# The input prerequisites is a graph represented by a list of edges, not
# adjacency matrices. Read more about how a graph is represented.
# You may assume that there are no duplicate edges in the input prerequisites.


# Topological Sort. See https://youtu.be/AfSk24UTFS8?list=PLUl4u3cNGP61Oq3tWYp6V_F-5jb5L2iHb&t=2516

# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Integer[]}
def find_order(num_courses, prerequisites)
  g = prerequisites.reduce(Array.new(num_courses) {[]}) { |h, (u, v)| h[v] << u; h}
  parent, topo, processing = {}, [], Array.new(num_courses, false)
  num_courses.times do |n|
    if !parent.has_key?(n)
      parent[n] = nil
      return [] if dfs(g, n, parent, processing, topo).nil?
    end
  end
  topo
end

# We don't need to use 'processing' if we do the checking with
# 'parent.has_key?(x) && !topo.include?(x)', but 'include?' method is
# O(n), so nah.

def dfs(g, n, parent, processing, topo)
  processing[n] = true
  g[n].each do |x|
    return if processing[x]
    if !parent.has_key?(x)
      parent[x] = n
      return if dfs(g, x, parent, processing, topo).nil?
    end
  end
  processing[n] = false
  topo.unshift n
end
