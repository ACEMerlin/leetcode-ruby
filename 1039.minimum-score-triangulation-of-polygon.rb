# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1039 lang=ruby
#
# [1039] Minimum Score Triangulation of Polygon
#
# https://leetcode.com/problems/minimum-score-triangulation-of-polygon/description/
#
# Given N, consider a convex N-sided polygon with vertices labelled
# A[0], A[i], ..., A[N-1] in clockwise order.
#
# Suppose you triangulate the polygon into N-2 triangles. For each
# triangle, the value of that triangle is the product of the labels of
# the vertices, and the total score of the triangulation is the sum of
# these values over all N-2 triangles in the triangulation.
#
# Return the smallest possible total score that you can achieve with
# some triangulation of the polygon.
#
# Example 1:
#
# Input: [1,2,3]
# Output: 6
# Explanation: The polygon is already triangulated, and the score of
# the only triangle is 6.
#
# Example 2:
#
# Input: [3,7,4,5]
# Output: 144
# Explanation: There are two triangulations, with possible scores: 3*7*5 +
# 4*5*7 = 245, or 3*4*5 + 3*4*7 = 144.  The minimum score is 144.
#
# Example 3:
#
# Input: [1,3,1,4,1,5]
# Output: 13
# Explanation: The minimum score triangulation has score 1*1*3 + 1*1*4
# + 1*1*5 + 1*1*1 = 13.
#
# Note:
#
# 3 <= A.length <= 50
# 1 <= A[i] <= 100


# DP. See:
#
#   - http://www.cs.utoronto.ca/~heap/Courses/270F02/A4/chains/node2.html
#   - https://www.geeksforgeeks.org/minimum-cost-polygon-triangulation/

# @param {Integer[]} a
# @return {Integer}
def min_score_triangulation(a)
  n = a.size
  d = Array.new(n) { Array.new(n, 0) }
  (2..n-1).each do |l|
    (0..n-l-1).each do |i|
      j, x = i+l, Float::INFINITY
      (i+1..j-1).each do |k|
        x = [x, d[i][k]+d[k][j]+a[i]*a[k]*a[j]].min
      end
      d[i][j] = x
    end
  end
  d[0][n-1]
end
