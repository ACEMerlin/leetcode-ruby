# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=48 lang=ruby
#
# [48] Rotate Image
#
# https://leetcode.com/problems/rotate-image/description/
#
# You are given an n x n 2D matrix representing an image.
#
# Rotate the image by 90 degrees (clockwise).
#
# Note:
#
# You have to rotate the image in-place, which means you have to
# modify the input 2D matrix directly. DO NOT allocate another 2D
# matrix and do the rotation.
#
# Example 1:
#
# Given input matrix =
# [
# ⁠ [1,2,3],
# ⁠ [4,5,6],
# ⁠ [7,8,9]
# ],
# rotate the input matrix in-place such that it becomes:
# [
# ⁠ [7,4,1],
# ⁠ [8,5,2],
# ⁠ [9,6,3]
# ]
#
# Example 2:
#
# Given input matrix =
# [
# ⁠ [ 5, 1, 9,11],
# ⁠ [ 2, 4, 8,10],
# ⁠ [13, 3, 6, 7],
# ⁠ [15,14,12,16]
# ],
# rotate the input matrix in-place such that it becomes:
# [
# ⁠ [15,13, 2, 5],
# ⁠ [14, 3, 4, 1],
# ⁠ [12, 6, 8, 9],
# ⁠ [16, 7,10,11]
# ]


# @param {Integer[][]} matrix
# @return {Void} Do not return anything, modify matrix in-place instead.
def rotate_a(a)
  n = a.size
  (0...n/2).each do |i|
    (i...n-1-i).each do |j|
      a[i][j], a[j][n-1-i], a[n-1-i][n-1-j], a[n-1-j][i] = a[n-1-j][i], a[i][j], a[j][n-1-i], a[n-1-i][n-1-j]
    end
  end
end


# 1. Reverse: a[i][j] = a[n-1-i][j].
# 2. Symmetry: a[n-1-i][j] = a[j][n-1-i].

def rotate(a)
  n = a.size
  a.reverse!
  (0...n).each do |i|
    (i+1...n).each do |j|
      a[i][j], a[j][i] = a[j][i], a[i][j]
    end
  end
end
