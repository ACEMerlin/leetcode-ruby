# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=516 lang=ruby
#
# [516] Longest Palindromic Subsequence
#
# https://leetcode.com/problems/longest-palindromic-subsequence/description/
#
# Given a string s, find the longest palindromic subsequence's length
# in s. You may assume that the maximum length of s is 1000.
#
# Example 1:
# Input: "bbbab"
# Output: 4
# One possible longest palindromic subsequence is "bbbb".
#
# Example 2:
# Input: "cbbd"
# Output: 2
# One possible longest palindromic subsequence is "bb".


# DP.
#
#   1. dp[i][j]: the length of longest palindrome in s[i..j].
#   2. dp[i][i] is 1.
#   3. dp[0][s.size-1] is the answer.

# @param {String} s
# @return {Integer}
def longest_palindrome_subseq(s)
  n = s.size
  dp = Array.new(n) { Array.new(n, 0) }
  (1..n).each do |l|
    (0..n-l).each do |i|
      j = i+l-1
      if i == j
        dp[i][j] = 1
      elsif s[i] == s[j]
        dp[i][j] = dp[i+1][j-1] + 2
      else
        dp[i][j] = [dp[i+1][j], dp[i][j-1]].max
      end
    end
  end
  dp[0][n-1]
end
