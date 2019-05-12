# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1043 lang=ruby
#
# [1043] Partition Array for Maximum Sum
#
# https://leetcode.com/problems/partition-array-for-maximum-sum/description/
#
# Given an integer array A, you partition the array into (contiguous)
# subarrays of length at most K. After partitioning, each subarray has
# their values changed to become the maximum value of that subarray.
#
# Return the largest sum of the given array after partitioning.
#
# Example 1:
#
# Input: A = [1,15,7,9,2,5,10], K = 3
# Output: 84
# Explanation: A becomes [15,15,15,9,10,10,10]
#
# Note:
#
# 1 <= K <= A.length <= 500
# 0 <= A[i] <= 10^6


# DP. d[i]: answer for a[i..-1].

# @param {Integer[]} a
# @param {Integer} k
# @return {Integer}
def max_sum_after_partitioning(a, k)
  n = a.size
  d = Array.new(n+1, 0)
  (n-1).downto(0) do |i|
    max = 0
    k.times do |j|
      break if i+j+1 > n
      max = [max, a[i+j]].max
      d[i] = [d[i], max*(j+1)+d[i+j+1]].max
    end
  end
  d[0]
end
