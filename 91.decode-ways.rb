# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=91 lang=ruby
#
# [91] Decode Ways
#
# https://leetcode.com/problems/decode-ways/description/
#
# A message containing letters from A-Z is being encoded to numbers
# using the following mapping:
#
# 'A' -> 1
# 'B' -> 2
# ...
# 'Z' -> 26
#
# Given a non-empty string containing only digits, determine the total
# number of ways to decode it.
#
# Example 1:
#
# Input: "12"
# Output: 2
# Explanation: It could be decoded as "AB" (1 2) or "L" (12).
#
# Example 2:
#
# Input: "226"
# Output: 3
# Explanation: It could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2
# 6).


# A classic DP problem, after solving problem
# 10-regular-expression-matching, this seems like child's play...
#
# Two tricky parts tho:
#   1. There are 0 ways to decode a string started with 0.
#   2. No need to check whether first two letters are bigger than 9,
#      we've already taken care of that in step 1.

# @param {String} s
# @return {Integer}
def num_decodings(s)
  dp = []
  dp[s.length] = 1
  (s.length-1).downto(0).each do |i|
    if s[i] == "0"
      dp[i] = 0
    else
      dp[i] = dp[i+1] + (i < s.length-1 && s[i,2].to_i <= 26 ? dp[i+2] : 0)
    end
  end
  dp[0]
end
