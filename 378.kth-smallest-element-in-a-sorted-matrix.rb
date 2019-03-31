# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=378 lang=ruby
#
# [378] Kth Smallest Element in a Sorted Matrix
#
# https://leetcode.com/problems/kth-smallest-element-in-a-sorted-matrix/description/
#
# Given a n x n matrix where each of the rows and columns are sorted
# in ascending order, find the kth smallest element in the matrix.
#
# Note that it is the kth smallest element in the sorted order, not the kth
# distinct element.
#
# Example:
#
# matrix = [
# ⁠  [ 1,  5,  9],
# ⁠  [10, 11, 13],
# ⁠  [12, 13, 15]
# ],
# k = 8,
#
# return 13.
#
# Note: You may assume k is always valid, 1 ≤ k ≤ n2.


# The first thing that hit my mind, just flatten and sort it...
# Time complexity: O(n+(n^2)*log(n^2)).

# @param {Integer[][]} matrix
# @param {Integer} k
# @return {Integer}
def kth_smallest_a(matrix, k)
  matrix.flatten.sort[k-1]
end


# Binary search, given:
# matrix = [
# ⁠  [ 1,  5,  9],
# ⁠  [10, 11, 13],
# ⁠  [12, 13, 15]
# ],
#   1. k=8, mid=(1+15)/2=8, for each row find the index of the first element that is larger than mid.
#   2. Sum up all the indices, 2+0+0 < k, which mean mid is too big, go 'left' side.
#   3. If it equals k, it means that we have k numbers that smaller or equal than that number,
#      which is exactly what we want -- the kth smallest number.
#
# Time complexity: O(n*log(n)*log(max-min))

def kth_smallest(matrix, k)
  lo, hi = matrix[0][0], matrix[-1][-1]
  (lo..hi).bsearch do |m|
    matrix.map do |x|
      (0..x.length).bsearch { |i| i == x.length || x[i] > m }
    end.sum >= k
  end
end
