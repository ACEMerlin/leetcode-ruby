# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=973 lang=ruby
#
# [973] K Closest Points to Origin
#
# https://leetcode.com/problems/k-closest-points-to-origin/description/
#
# We have a list of points on the plane. Find the K closest points to
# the origin (0, 0).
#
# (Here, the distance between two points on a plane is the Euclidean
# distance.)
#
# You may return the answer in any order. The answer is guaranteed to
# be unique (except for the order that it is in.)
#
# Example 1:
#
# Input: points = [[1,3],[-2,2]], K = 1
# Output: [[-2,2]]
# Explanation:
# The distance between (1, 3) and the origin is sqrt(10).
# The distance between (-2, 2) and the origin is sqrt(8).
# Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
# We only want the closest K = 1 points from the origin, so the answer is just
# [[-2,2]].
#
# Example 2:
#
# Input: points = [[3,3],[5,-1],[-2,4]], K = 2
# Output: [[3,3],[-2,4]]
# (The answer [[-2,4],[3,3]] would also be accepted.)
#
# Note:
#
# 1 <= K <= points.length <= 10000
# -10000 < points[i][0] < 10000
# -10000 < points[i][1] < 10000


# See problem 215, it's the same idea.

# @param {Integer[][]} points
# @param {Integer} k
# @return {Integer[][]}
def k_closest(points, k)
  points.shuffle!
  quick_select(points, k)
  points[0,k]
end

def quick_select(a, k, lo=0, hi=a.size-1)
  l, r = three_way_partition(a, lo, hi)
  if k < l
    quick_select(a, k, lo, l-1)
  elsif k > r+1
    quick_select(a, k, l+1, hi)
  end
end

def three_way_partition(a, lo, hi)
  lt, gt, i, p = lo, hi, lo+1, dist(a, lo)
  until i > gt
    d = dist(a, i)
    if d < p
      swap(a, i, lt)
      i += 1
      lt += 1
    elsif d > p
      swap(a, i, gt)
      gt -= 1
    else
      i += 1
    end
  end
  [lt, gt]
end

def swap(a, i, j)
  a[i], a[j] = a[j], a[i]
end

def dist(a, i)
  a[i][0]**2 + a[i][1]**2
end


# Or if you are lazy...

def k_closest_a(points, k)
  points.sort_by { |point| point[0]**2 + point[1]**2 }[0,k]
end
