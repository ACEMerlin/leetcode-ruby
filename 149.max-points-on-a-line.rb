# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=149 lang=ruby
#
# [149] Max Points on a Line
#
# https://leetcode.com/problems/max-points-on-a-line/description/
#
# Given n points on a 2D plane, find the maximum number of points that
# lie on the same straight line.
#
# Example 1:
#
# Input: [[1,1],[2,2],[3,3]]
# Output: 3
# Explanation:
# ^
# |
# |        o
# |     o
# |  o
# +------------->
# 0  1  2  3  4
#
# Example 2:
#
# Input: [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
# Output: 4
# Explanation:
# ^
# |
# |  o
# |     o        o
# |        o
# |  o        o
# +------------------->
# 0  1  2  3  4  5  6
#
# NOTE: input types have been changed on April 15, 2019. Please reset to
# default code definition to get new method signature.


# O(n^2).
#
# The key is how to uniquely identify a line:
#   1. Using y = ax + b will cause precision problem.
#   2. Using ax + by + c = 0, we can identify it using (a, b, c).
#      - We want all 'a's to be positive.
#      - We want (a/g, b/g, c/g) where g is the gcd(a, b, c).
#   3. Edge cases:
#      - duplicate points.
#      - vertical line and horzontal line.

# @param {Integer[][]} points
# @return {Integer}
def max_points(points)
  return points.size if points.size <= 2
  n, h = points.size, Hash.new { |h, k| h[k] = Set.new }
  (0..n-1).each do |i|
    (i+1..n-1).each do |j|
      x1, y1 = points[i]
      x2, y2 = points[j]
      if x1 == x2 && y1 == y2
        s = h["p:#{x1}:#{y1}"]
      elsif x1 == x2
        s = h["v:#{x1}"]
      elsif y1 == y2
        s = h["h:#{y1}"]
      else
        a, b, c = y2-y1, x1-x2, x2*y1-x1*y2
        a, b, c = -a, -b, -c if a < 0
        g = [a, b, c].reduce(&:gcd)
        a, b, c = a/g, b/g, c/g
        s = h["l:#{a}:#{b}:#{c}"]
      end
      s << [x1, y1] << [x2, y2]
    end
  end
  freq = points.reduce(Hash.new(0)) { |h, p| h[p] += 1; h };
  h.max_by { |k, v| v.sum { |p| freq[p] } }[1].sum { |p| freq[p] }
end
