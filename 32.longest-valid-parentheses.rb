# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=32 lang=ruby
#
# [32] Longest Valid Parentheses
#
# https://leetcode.com/problems/longest-valid-parentheses/description/
#
# Given a string containing just the characters '(' and ')', find the
# length of the longest valid (well-formed) parentheses substring.
#
# Example 1:
#
# Input: "(()"
# Output: 2
# Explanation: The longest valid parentheses substring is "()"
#
# Example 2:
#
# Input: ")()())"
# Output: 4
# Explanation: The longest valid parentheses substring is "()()"


# dp[i]: the longest valid substring ending at s[i].
#
# We have dp.size = s.size+1 and dp[-1]=0 so that we don't have to
# check i-2 > 0.

# @param {String} s
# @return {Integer}
def longest_valid_parentheses(s)
  dp, ans = Array.new(s.size+1, 0), 0
  (1...s.size).each do |i|
    next if s[i] == '('
    if s[i-1] == '('
      dp[i] = dp[i-2] + 2
    elsif i-dp[i-1] > 0 && s[i-dp[i-1]-1] == '('
      dp[i] = dp[i-dp[i-1]-2] + dp[i-1] + 2
    end
    ans = [ans, dp[i]].max
  end
  ans
end


# Another variation of this problem:
#
# See: other/longest-subsequence-of-balanced-parentheses.rb
