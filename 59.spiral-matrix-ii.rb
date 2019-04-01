# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=59 lang=ruby
#
# [59] Spiral Matrix II
#
# https://leetcode.com/problems/spiral-matrix-ii/description/
#
# Given a positive integer n, generate a square matrix filled with
# elements from 1 to n2 in spiral order.
#
# Example:
#
# Input: 3
# Output:
# [
# ⁠[ 1, 2, 3 ],
# ⁠[ 8, 9, 4 ],
# ⁠[ 7, 6, 5 ]
# ]


# for loop practice...

# @param {Integer} n
# @return {Integer[][]}
def generate_matrix(n)
  Array.new(n) { Array.new(n) }.tap { |r| helper(0, n-1, r) }
end

def helper(s, e, ans, x=1)
  return if s > e
  if s == e
    ans[s][e] = x
    return
  end
  (s..e).each { |j| ans[s][j] = x; x += 1 }
  (s+1..e).each { |i| ans[i][e] = x; x += 1 }
  (s..e-1).reverse_each { |j| ans[e][j] = x; x += 1 }
  (s+1..e-1).reverse_each { |i| ans[i][s] = x; x += 1 }
  helper(s+1, e-1, ans, x)
end
