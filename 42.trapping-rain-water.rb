# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=42 lang=ruby
#
# [42] Trapping Rain Water
#
# https://leetcode.com/problems/trapping-rain-water/description/
#
# Given n non-negative integers representing an elevation map where
# the width of each bar is 1, compute how much water it is able to
# trap after raining.
#
# The above elevation map is represented by array
# [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue
# section) are being trapped. Thanks Marcos for contributing this
# image!
#
# Example:
#
# Input: [0,1,0,2,1,0,1,3,2,1,2,1]
# Output: 6


# This is the O(n^2) method.
#
# e.g. Given [3,0,0,2,0,4]
#          |
#     |    |
#     |  | |
#     |__|_|
#
# For each index:
#   1. Find max height left of it
#   2. Find max height right of it
#   3. It contians min[left, right] - current_height
#
# In above case, it's 0+3+3+1+3+0=10

# @param {Integer[]} height
# @return {Integer}
def trap_a(height)
  ans, size = 0, height.length
  (0...(size-1)).each do |i|
    left = right = 0
    i.downto(0) { |j| left = [left, height[j]].max }
    i.upto(size-1) { |j| right = [right, height[j]].max }
    puts "i: #{i} left: #{left} right: #{right}"
    ans += [left, right].min - height[i]
  end
  ans
end



# Clearly we wasted a lot of time calculating max_left and max_right,
# given [3,0,0,2,0,4], we can see that for all indices, the max_left
# and max_right are all the same, let's fix that:
#
#   1. From left to right, we calculate max height upto the given
#      point and store it in an array.
#   2. From right to left, we calculate max height upto the given
#      point and store it in an array.

def trap_b(height)
  size = height.length
  lefts = 1.upto(size-1).reduce([height[0]]) do |l, i|
    l << [height[i], l[-1]].max
  end
  rights = (size-2).downto(0).reduce([height[-1]]) do |r, i|
    r.unshift([height[i], r[0]].max)
  end
  0.upto(size-1).reduce(0) do |ans, i|
    ans += [lefts[i], rights[i]].min - height[i]
  end
end



# The above method runs 3 passes through height, let's try one pass,
# but how are we gonna do that, let's recap with another example:
#
#    Given: [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1] (a)
# 1st pass: [0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3] (b)
# 2nd pass: [3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1] (c)
# 3rd pass: [0, 0, 1, 0, 1, 2, 1, 0, 0, 1, 0, 0] (d)   => 6
#
# Now, forget all about rain trapping, it's simply a game with numbers,
# we know that di = min(bi, ci) - ai, we can see the flipping point
# at index 7, `*` represents the numbers we don't need:
#
#    Given: [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1] (a)
# 1st pass: [0, 1, 1, 2, 2, 2, 2, 3, *, *, *, *] (b)
# 2nd pass: [*, *, *, *, *, *, *, 3, 2, 2, 2, 1] (c)
#
# Now it's easy to understand the following code

def trap(height)
  i, j = 0, height.length-1
  ans = max = 0
  while i < j
    if height[i] <= height[j]
      max = [max, height[i]].max
      ans += max - height[i]
      i += 1
    else
      max = [max, height[j]].max
      ans += max - height[j]
      j -= 1
    end
  end
  ans
end
