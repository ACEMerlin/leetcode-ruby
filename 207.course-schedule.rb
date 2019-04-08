# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=207 lang=ruby
#
# [207] Course Schedule
#
# https://leetcode.com/problems/course-schedule/description/
#
# There are a total of n courses you have to take, labeled from 0 to n-1.
#
# Some courses may have prerequisites, for example to take course 0
# you have to first take course 1, which is expressed as a pair: [0,1]
#
# Given the total number of courses and a list of prerequisite pairs,
# is it possible for you to finish all courses?
#
# Example 1:
#
# Input: 2, [[1,0]]
# Output: true
# Explanation: There are a total of 2 courses to take.
# To take course 1 you should have finished course 0. So it is possible.
#
# Example 2:
#
# Input: 2, [[1,0],[0,1]]
# Output: false
# Explanation: There are a total of 2 courses to take. To take course
# 1 you should have finished course 0, and to take course 0 you should
# also have finished course 1. So it is impossible.
#
# Note:
#
# The input prerequisites is a graph represented by a list of edges, not
# adjacency matrices. Read more about how a graph is represented.
# You may assume that there are no duplicate edges in the input prerequisites.


# Cycle Detection. See https://youtu.be/AfSk24UTFS8?list=PLUl4u3cNGP61Oq3tWYp6V_F-5jb5L2iHb&t=1840

# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish(num_courses, prerequisites)
  g = prerequisites.reduce(Array.new(num_courses) {[]}) { |h, (u, v)| h[v] << u; h}
  parent, processing = {}, Array.new(num_courses, false)
  num_courses.times do |n|
    if !parent.has_key?(n)
      parent[n] = nil
      cycle = dfs(g, n, parent, processing)
      return !cycle if cycle
    end
  end
  true
end

def dfs(g, n, parent, processing)
  processing[n] = true
  g[n].each do |x|
    return true if processing[x]
    if !parent.has_key?(x)
      parent[x] = n
      cycle = dfs(g, x, parent, processing)
      return cycle if cycle
    end
  end
  processing[n] = false
  false
end
