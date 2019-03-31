# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=240 lang=ruby
#
# [240] Search a 2D Matrix II
#
# https://leetcode.com/problems/search-a-2d-matrix-ii/description/
#
# Write an efficient algorithm that searches for a value in an m x n
# matrix. This matrix has the following properties:
#
# Integers in each row are sorted in ascending from left to right.
# Integers in each column are sorted in ascending from top to bottom.
#
# Example:
#
# Consider the following matrix:
#
# [
# ⁠ [1,   4,  7, 11, 15],
# ⁠ [2,   5,  8, 12, 19],
# ⁠ [3,   6,  9, 16, 22],
# ⁠ [10, 13, 14, 17, 24],
# ⁠ [18, 21, 23, 26, 30]
# ]
#
# Given target = 5, return true.
#
# Given target = 20, return false.


# The key point is to check the top right corner.

# @param {Integer[][]} matrix
# @param {Integer} target
# @return {Boolean}
def search_matrix(matrix, target)
  k = -1
  matrix.each do |s|
    k -= 1 while s[k] && target < s[k]
    return true if s[k] == target
  end
  false
end
