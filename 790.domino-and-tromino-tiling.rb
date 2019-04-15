# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=790 lang=ruby
#
# [790] Domino and Tromino Tiling
#
# https://leetcode.com/problems/domino-and-tromino-tiling/description/
#
# We have two types of tiles: a 2x1 domino shape, and an "L" tromino
# shape. These shapes may be rotated.
#
# XX  <- domino
#
# XX  <- "L" tromino
# X
#
# Given N, how many ways are there to tile a 2 x N board? Return your
# answer modulo 10^9 + 7.
#
# (In a tiling, every square must be covered by a tile. Two tilings
# are different if and only if there are two 4-directionally adjacent
# cells on the board such that exactly one of the tilings has both
# squares occupied by a tile.)
#
# Example:
# Input: 3
# Output: 5
# Explanation:
# The five different ways are listed below, different letters indicates
# different tiles:
# XYZ XXZ XYY XXY XYY
# XYZ YYZ XZZ XYY XXY
#
# Note:
#
# N  will be in range [1, 1000].


# See https://journeywithdp.blogspot.com/2018/07/way-to-solve-tiling-problems.html

# f(n) = f(n-1) + f(n-2) + 2 * g(n-1)
# g(n) = f(n-2) + g(n-1)

# @param {Integer} n
# @return {Integer}
def num_tilings_a(n)
  f = Array.new(n, 0)
  g = Array.new(n, 0)
  f[0] = 1
  f[1] = 2
  g[1] = 1
  (2..n-1).each do |i|
    f[i] = (f[i-1] + f[i-2] + 2 * g[i-1]) % 1000000007
    g[i] = (f[i-2] + g[i-1]) % 1000000007
  end
  f[n-1]
end

# If you combine f(n) and g(n) you'll see:
# f(n) = f(n-1) + f(n-2) + 2 * (f(n-3) + g(n-2))
# cuz f(n-1) = f(n-2) + f(n-3) + 2 * g(n-2)
# so we have f(n) = 2 * f(n-1) + f(n-3)

def num_tilings(n)
  f = Array.new(n, 0)
  f[0] = 1
  f[1] = 2
  f[2] = 5
  (3..n-1).each do |i|
    f[i] = (2 * f[i-1] + f[i-3]) % 1000000007
  end
  f[n-1]
end
