# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=73 lang=ruby
#
# [73] Set Matrix Zeroes
#
# https://leetcode.com/problems/set-matrix-zeroes/description/
#
# Given a m x n matrix, if an element is 0, set its entire row and
# column to 0. Do it in-place.
#
# Example 1:
#
# Input:
# [
# [1,1,1],
# [1,0,1],
# [1,1,1]
# ]
# Output:
# [
# [1,0,1],
# [0,0,0],
# [1,0,1]
# ]
#
# Example 2:
#
# Input:
# [
# [0,1,2,0],
# [3,4,5,2],
# [1,3,1,5]
# ]
# Output:
# [
# [0,0,0,0],
# [0,4,5,0],
# [0,3,1,0]
# ]
#
# Follow up:
#
# A straight forward solution using O(mn) space is probably a bad idea.
# A simple improvement uses O(m + n) space, but still not the best
# solution.
# Could you devise a constant space solution?


# O(m+n) space.

# @param {Integer[][]} matrix
# @return {Void} Do not return anything, modify matrix in-place instead.
def set_zeroes(matrix)
  rows, cols = Set.new, Set.new
  matrix.each_with_index do |r, i|
    r.each_with_index do |c, j|
      if matrix[i][j] == 0
        rows << i
        cols << j
      end
    end
  end
  rows.each do |i|
    matrix[i] = Array.new(matrix[0].size, 0)
  end
  cols.each do |j|
    matrix.size.times do |i|
      matrix[i][j] = 0
    end
  end
end


# O(1) space.
#
#   1. If m[i][j] == 0 then set m[0][j] = 0 and m[i][0] = 0.
#   2. For all i and j, set its row/col to 0 if m[0][j] == 0 || m[i][0] == 0.
#   3. Two edge cases are m[0][0] and first column.

def set_zeroes(matrix)
  return if matrix.empty?
  m, n = matrix.size, matrix[0].size
  edge = false
  (0..m-1).each do |i|
    edge = true if matrix[i][0] == 0
    (1..n-1).each do |j|
      if matrix[i][j] == 0
        matrix[i][0] = 0
        matrix[0][j] = 0
      end
    end
  end
  (1..m-1).each do |i|
    (1..n-1).each do |j|
      matrix[i][j] = 0 if matrix[i][0] == 0 || matrix[0][j] == 0
    end
  end
  if matrix[0][0] == 0
    matrix[0] = Array.new(n, 0)
  end
  if edge
    (0..m-1).each do |i|
      matrix[i][0] = 0
    end
  end
end
