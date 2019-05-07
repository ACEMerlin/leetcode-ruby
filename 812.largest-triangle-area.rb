# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=812 lang=ruby
#
# [812] Largest Triangle Area
#
# https://leetcode.com/problems/largest-triangle-area/description/
#
# You have a list of points in the plane. Return the area of the
# largest triangle that can be formed by any 3 of the points.
#
# Example:
# Input: points = [[0,0],[0,1],[1,0],[0,2],[2,0]]
# Output: 2
# Explanation:
# The five points are show in the figure below. The red triangle is the
# largest.
#
# Notes:
#
# 3 <= points.length <= 50.
# No points will be duplicated.
# -50 <= points[i][j] <= 50.
# Answers withinw10^-6 of the true value will be accepted as correct.


# I use Convex Hull algorithm here to reduce the number of points
# being considered. Brute Force all points also seems to be working.

# @param {Integer[][]} points
# @return {Float}
def largest_triangle_area(points)
  x0, y0 = points.min_by { |(x, y)| [y, x] }
  p1, p2, *ps = points.sort_by { |(x, y)| [Math.atan2(y-y0, x-x0), x] }
  h = [p1, p2].tap do |q|
    ps.each do |p|
      q.pop while q.size > 1 && !ccw?(q[-2], q[-1], p)
      q << p
    end
  end
  n, ans = h.size, -Float::INFINITY
  (0..n-1).each do |i|
    (i+1..n-1).each do |j|
      (j+1..n-1).each do |k|
        ans = [ans, area(h[i], h[j], h[k])].max
      end
    end
  end
  ans
end

def vproduct((x1, y1), (x2, y2), (x3, y3))
  (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1)
end

def ccw?(a, b, c)
  vproduct(a, b, c) > 0
end

def area(a, b, c)
  vproduct(a, b, c).fdiv(2)
end
