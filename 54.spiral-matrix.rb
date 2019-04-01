# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=54 lang=ruby
#
# [54] Spiral Matrix
#
# https://leetcode.com/problems/spiral-matrix/description/
#
# Given a matrix of m x n elements (m rows, n columns), return all
# elements of the matrix in spiral order.
#
# Example 1:
#
# Input:
# [
# ⁠[ 1, 2, 3 ],
# ⁠[ 4, 5, 6 ],
# ⁠[ 7, 8, 9 ]
# ]
# Output: [1,2,3,6,9,8,7,4,5]
#
# Example 2:
#
# Input:
# [
# ⁠ [1, 2, 3, 4],
# ⁠ [5, 6, 7, 8],
# ⁠ [9,10,11,12]
# ]
# Output: [1,2,3,4,8,12,11,10,9,5,6,7]


# for loop practice...

# @param {Integer[][]} matrix
# @return {Integer[]}
def spiral_order(matrix)
  return [] if matrix.empty?
  helper(matrix)
end

def helper(matrix, si=0, sj=0, ei=matrix.size-1, ej=matrix[0].size-1, ans=[])
  return if si > ei
  return if sj > ej
  (sj..ej).each { |x| ans << matrix[si][x] }
  (si+1..ei).each { |x| ans << matrix[x][ej] }
  (sj..ej-1).reverse_each { |x| ans << matrix[ei][x] } if ei != si
  (si+1..ei-1).reverse_each { |x| ans << matrix[x][sj] } if ej != sj
  helper(matrix, si+1, sj+1, ei-1, ej-1, ans)
  ans
end
