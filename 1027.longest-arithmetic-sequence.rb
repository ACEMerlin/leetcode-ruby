# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1027 lang=ruby
#
# [1027] Longest Arithmetic Sequence
#
# https://leetcode.com/problems/longest-arithmetic-sequence/description/
#
# Given an array A of integers, return the length of the longest
# arithmetic subsequence in A.
#
# Recall that a subsequence of A is a list A[i_1], A[i_2], ..., A[i_k]
# with 0 <= i_1 < i_2 < ... < i_k <= A.length - 1, and that a sequence
# B is arithmetic if B[i+1] - B[i] are all the same value (for 0 <= i
# < B.length - 1).
#
# Example 1:
#
# Input: [3,6,9,12]
# Output: 4
# Explanation:
# The whole array is an arithmetic sequence with steps of length = 3.
#
# Example 2:
#
# Input: [9,4,7,2,10]
# Output: 3
# Explanation:
# The longest arithmetic subsequence is [4,7,10].
#
# Example 3:
#
# Input: [20,1,15,3,10,5,8]
# Output: 4
# Explanation:
# The longest arithmetic subsequence is [20,15,10,5].
#
# Note:
#
# 2 <= A.length <= 2000
# 0 <= A[i] <= 10000


# This one will get TLE. I just put it here cuz it's easier to understand.
#
#   dp[[diff, i]]: length of arithmetic subsequence up to index i with
#                  difference 'diff'.
#
# E.g.: [20, 1, 15, 3, 10, 5, 8]
# dp[[1-20, 1]] => dp[[-19, 1]] => 2
# dp[[15-20, 2]] => dp[[-15, 2]] => 2
# dp[[15-1, 2]] => dp[[14, 2]] => 2
# ...
# dp[[10-15], 4] = dp[[15-20], 2] + 1 => 3
# ...
# dp[[5-10, 5]] = dp[[10-15, 4]] + 1 => 4
#
# given x < k < j < i, and diff = a[k]-a[x] == a[j]-a[k] == a[i]-a[j]
# dp[diff, j] will be updated after updating dp[diff, k], hence
# dp[diff, j] > dp[diff, k], and for each i we have j scaning from
# left to right, so just update dp[diff, i] = dp[diff, j] + 1, and in
# the end it'll be the largest.

# @param {Integer[]} a
# @return {Integer}
def longest_arith_seq_length(a)
  dp, n, ans = {}, a.size, -Float::INFINITY
  (1..n-1).each do |j|
    (0..j-1).each do |i|
      diff = a[j] - a[i]
      if dp.has_key?([diff, i])
        dp[[diff, j]] = dp[[diff, i]] + 1
      else
        dp[[diff, j]] = 2
      end
      ans = [ans, dp[[diff, j]]].max
    end
  end
  ans
end


# Same idea, use array of hashes instead of just a big hash.

def longest_arith_seq_length(a)
  dp, n, ans = Array.new(a.size) {{}},  a.size, -Float::INFINITY
  (1..n-1).each do |j|
    (0..j-1).each do |i|
      diff = a[j] - a[i]
      if dp[i].has_key?(diff)
        dp[j][diff] = dp[i][diff] + 1
      else
        dp[j][diff] = 2
      end
      ans = [ans, dp[j][diff]].max
    end
  end
  ans
end
