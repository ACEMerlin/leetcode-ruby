# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=74 lang=ruby
#
# [74] Search a 2D Matrix
#
# https://leetcode.com/problems/search-a-2d-matrix/description/
#
# Write an efficient algorithm that searches for a value in an m x n
# matrix. This matrix has the following properties:
#
# Integers in each row are sorted from left to right. The first
# integer of each row is greater than the last integer of the previous
# row.
#
# Example 1:
#
# Input:
# matrix = [
# ⁠ [1,   3,  5,  7],
# ⁠ [10, 11, 16, 20],
# ⁠ [23, 30, 34, 50]
# ]
# target = 3
# Output: true
#
# Example 2:
#
# Input:
# matrix = [
# ⁠ [1,   3,  5,  7],
# ⁠ [10, 11, 16, 20],
# ⁠ [23, 30, 34, 50]
# ]
# target = 13
# Output: false


# Use build-in bsearch.

# @param {Integer[][]} matrix
# @param {Integer} target
# @return {Boolean}
def search_matrix(matrix, target)
  !matrix.bsearch { |sub| !sub[-1].nil? && target <= sub[-1] }&.bsearch { |x| target <=> x }.nil?
end


# Or implement your own discrete binary search.

def search_matrix_a(matrix, target)
  sub = bsearch(matrix) { |sub| !sub[-1].nil? && target <= sub[-1] }
  found = bsearch(sub) { |x| target >= x }
  !found.nil? && found == target
end

def bsearch(objs)
  return if objs.nil? || objs.empty?
  lo, hi = 0, objs.length-1
  while lo < hi
    mid = lo + (hi-lo) / 2
    if yield(objs[mid])
      hi = mid
    else
      lo = mid + 1
    end
  end
  return objs[lo] if yield(objs[lo])
end


# Or, you can sit down and write all this.
def search_matrix_b(matrix, target)
  lo, hi = 0, matrix.length-1
  while lo <= hi
    mid = (lo + hi) / 2
    cur = matrix[mid]
    break if cur.empty?
    if target < cur[0]
      hi = mid - 1
    elsif target > cur[-1]
      lo = mid + 1
    else
      found = my_bsearch(cur, target)
      break
    end
  end
  !found.nil?
end

def my_bsearch(arr, target)
  lo, hi = 0, arr.length-1
  while lo <= hi
    mid = (lo + hi) / 2
    if arr[mid] == target
      return target
    elsif arr[mid] > target
      hi = mid - 1
    else
      lo = mid + 1
    end
  end
end
