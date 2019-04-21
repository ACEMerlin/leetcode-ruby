# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1031 lang=ruby
#
# [1031] Maximum Sum of Two Non-Overlapping Subarrays
#
# https://leetcode.com/problems/maximum-sum-of-two-non-overlapping-subarrays/description/
#
# Given an array A of non-negative integers, return the maximum sum of
# elements in two non-overlapping (contiguous) subarrays, which have
# lengths L and M. (For clarification, the L-length subarray could
# occur before or after the M-length subarray.)
#
# Formally, return the largest V for which V = (A[i] + A[i+1] + ... +
# A[i+L-1]) + (A[j] + A[j+1] + ... + A[j+M-1]) and either:
#
# 0 <= i < i + L - 1 < j < j + M - 1 < A.length, or
# 0 <= j < j + M - 1 < i < i + L - 1 < A.length.
#
# Example 1:
#
# Input: A = [0,6,5,2,2,5,1,9,4], L = 1, M = 2
# Output: 20
# Explanation: One choice of subarrays is [9] with length 1, and [6,5]
# with length 2.
#
# Example 2:
#
# Input: A = [3,8,1,3,2,1,8,9,0], L = 3, M = 2
# Output: 29
# Explanation: One choice of subarrays is [3,8,1] with length 3, and
# [8,9] with length 2.
#
# Example 3:
#
# Input: A = [2,1,5,6,0,9,5,0,3,8], L = 4, M = 3
# Output: 31
# Explanation: One choice of subarrays is [5,6,0,9] with length 4, and
# [3,8] with length 3.
#
# Note:
#
# L >= 1
# M >= 1
# L + M <= A.length <= 1000
# 0 <= A[i] <= 1000


# @param {Integer[]} a
# @param {Integer} l
# @param {Integer} m
# @return {Integer}
def max_sum_two_no_overlap(a, l, m)
  p = a.reduce([]) { |h, n| h << (h[-1]||0)+n } << 0
  [max_sum(p, l, m), max_sum(p, m, l)].max
end

def max_sum(p, l, m)
  max = -Float::INFINITY
  left = (l-1..p.size-2).reduce([]) do |h, i|
    h << max = [range(p, i-l+1, i), max].max
  end
  max = -Float::INFINITY
  right = (p.size-2).downto(m-1).reduce([]) do |h, i|
    h.unshift(max = [range(p, i-m+1, i), max].max)
  end
  ans = -Float::INFINITY
  left.each_with_index do |n, i|
    ans = [ans, n+right[i+l]].max if i+l < right.size
  end
  ans
end

def range(p, lo, hi)
  p[hi] - p[lo-1]
end
