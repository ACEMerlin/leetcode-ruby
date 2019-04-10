# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=276 lang=ruby
#
# [276] Paint Fence
#
# https://leetcode.com/problems/paint-fence/description/
#
# There is a fence with n posts, each post can be painted with one of
# the k colors. You have to paint all the posts such that no more than
# two adjacent fence posts have the same color.
#
# Return the total number of ways you can paint the fence.
#
# Note: n and k are non-negative integers.


# DP.
#   0. dp[i]: the answer up to the ith post.
#   1. i and i-1 have the same color, then dp[i] is dp[i-2]*(k-1).
#      (i-2 and i have different color)
#   2. i and i-1 have different color, then dp[i] is dp[i-1]*(k-1).
#   3. Combine these two we have dp[i] = (k-1) * (dp[i-1]+dp[i-2])

def num_ways_a(n, k)
  dp = [0, k, k*k]
  (3..n).each do |i|
    dp[i] = (k-1) * (dp[i-1]+dp[i-2])
  end
  dp[n]
end


# Above method always use the last two elements in dp array, so to
# save space we can use variables to store them.

def num_ways(n, k)
  return 0 if n == 0
  d1, d2, d3 = k, k*k
  return d1 if n == 1
  return d2 if n == 2
  (3..n).each do
    d3 = (k-1) * (d1+d2)
    d1 = d2
    d2 = d3
  end
  d3
end
