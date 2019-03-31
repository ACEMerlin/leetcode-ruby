# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=11 lang=ruby
#
# [11] Container With Most Water
#
# https://leetcode.com/problems/container-with-most-water/description/
#
# Given n non-negative integers a1, a2, ..., an, where each
# represents a point at coordinate (i, ai). n vertical lines are drawn
# such that the two endpoints of line i is at (i, ai) and (i, 0). Find
# two lines, which together with x-axis forms a container, such that
# the container contains the most water.
#
# Note: You may not slant the container and n is at least 2.
#
# The above vertical lines are represented by array
# [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue
# section) the container can contain is 49.
#
# Example:
#
# Input: [1,8,6,2,5,4,8,3,7]
# Output: 49


# Given i and j, it contains v = [h[i], h[j]].min * (j-i), so you can
# see that in order to make v bigger, we need to change the smaller
# one of h[i] and h[j], changing the bigger one doesn't help at all.

# @param {Integer[]} height
# @return {Integer}
def max_area(height)
  i, j, max = 0, height.length-1, 0
  while i < j
    v = height.values_at(i,j).min * (j - i)
    max = [max, v].max
    if height[i] < height[j]
      i += 1
    else
      j -= 1
    end
  end
  max
end
