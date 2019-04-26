# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=718 lang=ruby
#
# [718] Maximum Length of Repeated Subarray
#
# https://leetcode.com/problems/maximum-length-of-repeated-subarray/description/
#
# Given two integer arrays A and B, return the maximum length of an
# subarray that appears in both arrays.
#
# Example 1:
#
# Input:
# A: [1,2,3,2,1]
# B: [3,2,1,4,7]
# Output: 3
# Explanation:
# The repeated subarray with maximum length is [3, 2, 1].
#
# Note:
#
# 1 <= len(A), len(B) <= 1000
# 0 <= A[i], B[i] < 100


# DP. O(n^2).

# @param {Integer[]} a
# @param {Integer[]} b
# @return {Integer}
def find_length(a, b)
  m, n = a.size, b.size
  d, ans = Array.new(a.size+1) { Array.new(b.size+1, 0) }, 0
  (m-1).downto(0) do |i|
    (n-1).downto(0) do |j|
      d[i][j] = d[i+1][j+1]+1 if a[i] == b[j]
      ans = [ans, d[i][j]].max
    end
  end
  ans
end


# TODO O(n*log(n))?
