# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=661 lang=ruby
#
# [661] Image Smoother
#
# https://leetcode.com/problems/image-smoother/description/
#
# Given a 2D integer matrix M representing the gray scale of an image, you need
# to design a smoother to make the gray scale of each cell becomes the average
# gray scale (rounding down) of all the 8 surrounding cells and itself.  If a
# cell has less than 8 surrounding cells, then use as many as you can.
#
# Example 1:
#
# Input:
# [[1,1,1],
# ⁠[1,0,1],
# ⁠[1,1,1]]
# Output:
# [[0, 0, 0],
# ⁠[0, 0, 0],
# ⁠[0, 0, 0]]
# Explanation:
# For the point (0,0), (0,2), (2,0), (2,2): floor(3/4) = floor(0.75) = 0
# For the point (0,1), (1,0), (1,2), (2,1): floor(5/6) = floor(0.83333333) = 0
# For the point (1,1): floor(8/9) = floor(0.88888889) = 0
#
# Note:
#
# The value in the given matrix is in the range of [0, 255].
# The length and width of the given matrix are in the range of [1, 150].


# @param {Integer[][]} m
# @return {Integer[][]}
def image_smoother(m)
  w, h = m[0].size, m.size
  ans = Array.new(h) { Array.new(w, 0) }
  (0..h-1).each do |i|
    (0..w-1).each do |j|
      c, sum = 0, 0
      [i-1, i, i+1].each do |x|
        [j-1, j, j+1].each do |y|
          if x >=0 && x < h && y >= 0 && y < w
            c += 1
            sum += m[x][y]
          end
        end
      end
      ans[i][j] = sum / c
    end
  end
  ans
end
