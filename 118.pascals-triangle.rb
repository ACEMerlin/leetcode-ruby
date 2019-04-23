# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=118 lang=ruby
#
# [118] Pascal's Triangle
#
# https://leetcode.com/problems/pascals-triangle/description/
#
# Given a non-negative integer numRows, generate the first numRows of
# Pascal's triangle.
#
# In Pascal's triangle, each number is the sum of the two numbers
# directly above it.
#
# Example:
#
# Input: 5
# Output:
# [
# ⁠    [1],
# ⁠   [1,1],
# ⁠  [1,2,1],
# ⁠ [1,3,3,1],
# ⁠[1,4,6,4,1]
# ]


# Recursive.

# @param {Integer} num_rows
# @return {Integer[][]}
def generate(num_rows, x=[[1]], k=1)
  return [] if num_rows.zero?
  return x if k == num_rows
  k += 1
  prev = x[-1]
  cur = (1..k-2).map { |i| prev[i-1]+prev[i] }
  cur.unshift 1
  cur << 1
  x << cur
  generate(num_rows, x, k)
end


# Iterative.

def generate(num_rows)
  return [] if num_rows.zero?
  ans = [[1]]
  (1..num_rows-1).each do |i|
    prev = ans[-1]
    cur = (1..i-1).map { |i| prev[i-1]+prev[i] }
    cur.unshift 1
    cur << 1
    ans << cur
  end
  ans
end
