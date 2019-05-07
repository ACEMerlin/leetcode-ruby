# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1037 lang=ruby
#
# [1037] Valid Boomerang
#
# https://leetcode.com/problems/valid-boomerang/description/
#
# A boomerang is a set of 3 points that are all distinct and not in a
# straight line.
#
# Given a list of three points in the plane, return whether these
# points are a boomerang.
#
# Example 1:
#
# Input: [[1,1],[2,3],[3,2]]
# Output: true
#
# Example 2:
#
# Input: [[1,1],[2,2],[3,3]]
# Output: false
#
# Note:
#
# points.length == 3
# points[i].length == 2
# 0 <= points[i][j] <= 100


# The area of the triangle formed by these points should not be 0.
# See: https://math.stackexchange.com/a/1414021

# @param {Integer[][]} points
# @return {Boolean}
def is_boomerang(points)
  x1, y1 = points[0]
  x2, y2 = points[1]
  x3, y3 = points[2]
  (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1) != 0
end
