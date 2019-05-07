# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=587 lang=ruby
#
# [587] Erect the Fence
#
# https://leetcode.com/problems/erect-the-fence/description/
#
# There are some trees, where each tree is represented by (x,y)
# coordinate in a two-dimensional garden. Your job is to fence the
# entire garden using the minimum length of rope as it is expensive.
# The garden is well fenced only if all the trees are enclosed. Your
# task is to help find the coordinates of trees which are exactly
# located on the fence perimeter.
#
# Example 1:
#
# Input: [[1,1],[2,2],[2,0],[2,4],[3,3],[4,2]]
# Output: [[1,1],[2,0],[4,2],[3,3],[2,4]]
#
# Example 2:
#
# Input: [[1,2],[2,2],[4,2]]
# Output: [[1,2],[2,2],[4,2]]
#
# Even you only have trees in a line, you need to use rope to enclose
# them.
#
# Note:
#
# All trees should be enclosed together. You cannot cut the rope to enclose
# trees that will separate them in more than one group.
# All input integers will range from 0 to 100.
# The garden has at least one tree.
# All coordinates are distinct.
# Input points have NO order. No order required for output.
# input types have been changed on April 15, 2019. Please reset to default code
# definition to get new method signature.


# Graham Scan.
#
# This is the Convex Hull problem, see: https://github.com/ACEMerlin/JustSnap/blob/master/Gosling/src/main/java/sortings/convex_hull/README.md
#
# Notice that for the collinear points with largest polar angle we
# need to proccess the furthest points first.

# @param {Integer[][]} points
# @return {Integer[][]}
def outer_trees(points)
  return points if points.size <= 3
  x0, y0 = points.min_by { |(x, y)| [y, x] }
  p1, p2, *ps = points.sort_by { |(x, y)| [Math.atan2(y-y0, x-x0), x] }
  fix_largest_angle(p1, ps)
  [p1, p2].tap do |q|
    ps.each do |p|
      q.pop while q.size > 1 && clockwise?(q[-2], q[-1], p)
      q << p
    end
  end
end

def clockwise?(a, b, c)
  vproduct(a, b, c) < 0
end

def collinear?(a, b, c)
  vproduct(a, b, c) == 0
end

def vproduct((x1, y1), (x2, y2), (x3, y3))
  (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1)
end

def fix_largest_angle(p, ps)
  b = ps[-1]
  i = ps.size-2
  i -= 1 while collinear?(p, b, ps[i])
  ps[i+1..-1] = ps[i+1..-1].sort_by { |(x, y)| -((x-p[0])**2+(y-p[1])**2) }
end
