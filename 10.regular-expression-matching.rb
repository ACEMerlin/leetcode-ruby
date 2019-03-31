# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=10 lang=ruby
#
# [10] Regular Expression Matching
#
# https://leetcode.com/problems/regular-expression-matching/description/
#
# Given an input string (s) and a pattern (p), implement regular
# expression matching with support for '.' and '*'.
#
# '.' Matches any single character.
# '*' Matches zero or more of the preceding element.
#
# The matching should cover the entire input string (not partial).
#
# Note:
#
# s could be empty and contains only lowercase letters a-z. p could be
# empty and contains only lowercase letters a-z, and characters like .
# or *.
#
# Example 1:
#
# Input: s = "aa", p = "a"
# Output: false
# Explanation: "a" does not match the entire string "aa".
#
# Example 2:
#
# Input: s = "aa", p = "a*"
# Output: true
# Explanation: '*' means zero or more of the precedeng element, 'a'.
# Therefore, by repeating 'a' once, it becomes "aa".
#
# Example 3:
#
# Input: s = "ab", p = ".*"
# Output: true
# Explanation: ".*" means "zero or more (*) of any character (.)".
#
# Example 4:
#
# Input: s = "aab", p = "c*a*b"
# Output: true
# Explanation: c can be repeated 0 times, a can be repeated 1 time.
# Therefore it matches "aab".
#
# Example 5:
#
# Input: s = "mississippi", p = "mis*is*p*."
# Output: false


# Recursive version, e.g. given (str, "c*a*b").
#
#   1. it's the same as (str, "a*b") if "a*b" can still match.
#   2. it's the same as (str[1..-1], "c*a*b") if the first character
#      is 'c' or '.'.
#   3. otherwise just check if both first character matches and
#      recursively call on their tails.
#
# When pattern is empty, the string to match should also be empty.

def is_match_a(s, p)
  return s.empty? if p.empty?
  first = !s.empty? && [s[0], '.'].include?(p[0])
  if p[1] == '*'
    is_match_a(s, p[2..-1]) || (first && is_match_a(s[1..-1], p))
  else
    first && is_match_a(s[1..-1], p[1..-1])
  end
end


# Slicing string is actually an O(n) operation, so instead we should
# use indices to mark the starting point of our substring. i -> s, j
# -> p, when j reaches the end, i should also reaches the end.

def is_match_b(s, p, i = 0, j = 0)
  return i == s.length if j == p.length
  first = i < s.length && [s[i], '.'].include?(p[j])
  if p[j+1] == '*'
    is_match_b(s, p, i, j+2) || (first && is_match_b(s, p, i+1, j))
  else
    first && is_match_b(s, p, i+1, j+1)
  end
end

# As you can see, the result of is_match_b can be memorized using i and j
# But we'll actually never hit the memo because i and j are always
# moving forward.

def is_match_c(s, p, i = 0, j = 0, memo = {})
  return i == s.length if j == p.length
  return memo[[i,j]] if memo.has_key?([i,j])
  first = i < s.length && [s[i], '.'].include?(p[j])
  if p[j+1] == '*'
    is_match_c(s, p, i, j+2, memo) || (first && is_match_c(s, p, i+1, j, memo))
  else
    first && is_match_c(s, p, i+1, j+1, memo)
  end
end


# Let's use bottom-up dp instead of top-down recursion with memo
#
#   1. dp[i][j] means that s and p matches when starting from index i
#      and j.
#   2. clearly when dp[s.length][p.length] is true, we also want
#      dp[0][0] to be true.
#   3. we need to iterate i through all (0..s.length) and j through
#      all (0..p.length). since we already have dp[-1][-1]=true, we
#      only need j to iterate through (0..(p.length-1)).

def is_match(s, p)
  m, n = s.length, p.length
  dp = Array.new(m+1) { Array.new(n+1, false) }
  dp[m][n] = true
  m.downto(0) do |i|
    (n-1).downto(0) do |j|
      first = i < m && (s[i] == p[j] || p[j] == '.')
      if p[j+1] == '*'
        dp[i][j] = dp[i][j+2] || (first && dp[i+1][j])
      else
        dp[i][j] = first && dp[i+1][j+1]
      end
    end
  end
  dp[0][0]
end
