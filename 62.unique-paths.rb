# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=62 lang=ruby
#
# [62] Unique Paths
#
# https://leetcode.com/problems/unique-paths/description/
#
# A robot is located at the top-left corner of a m x n grid (marked
# 'Start' in the diagram below).
#
# The robot can only move either down or right at any point in time.
# The robot is trying to reach the bottom-right corner of the grid
# (marked 'Finish' in the diagram below).
#
# How many possible unique paths are there?
#
# Above is a 7 x 3 grid. How many possible unique paths are there?
#
# Note: m and n will be at most 100.
#
# Example 1:
#
# Input: m = 3, n = 2
# Output: 3
# Explanation:
# From the top-left corner, there are a total of 3 ways to reach the
# bottom-right corner:
# 1. Right -> Right -> Down
# 2. Right -> Down -> Right
# 3. Down -> Right -> Right
#
# Example 2:
#
# Input: m = 7, n = 3
# Output: 28


# Recursive version.

# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths_a(m, n)
  return 1 if m == 1 || n == 1
  unique_paths(m, n-1) + unique_paths(m-1, n)
end


# DP version.

def unique_paths(m, n)
  dp = Array.new(m+1) { Array.new(n+1, 0) }
  (1..m).each do |i|
    (1..n).each do |j|
      if i == 1 || j == 1
        dp[i][j] = 1
      else
        dp[i][j] = dp[i][j-1] + dp[i-1][j]
      end
    end
  end
  dp[m][n]
end
