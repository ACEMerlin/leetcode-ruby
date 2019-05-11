# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=44 lang=ruby
#
# [44] Wildcard Matching
#
# https://leetcode.com/problems/wildcard-matching/description/
#
# Given an input string (s) and a pattern (p), implement wildcard
# pattern matching with support for '?' and '*'.
#
# '?' Matches any single character.
# '*' Matches any sequence of characters (including the empty sequence).
#
# The matching should cover the entire input string (not partial).
#
# Note:
#
# s could be empty and contains only lowercase letters a-z.
# p could be empty and contains only lowercase letters a-z, and characters like
# ? or *.
#
# Example 1:
#
# Input:
# s = "aa"
# p = "a"
# Output: false
# Explanation: "a" does not match the entire string "aa".
#
# Example 2:
#
# Input:
# s = "aa"
# p = "*"
# Output: true
# Explanation:t'*' matches any sequence.
#
# Example 3:
#
# Input:
# s = "cb"
# p = "?a"
# Output: false
# Explanation: '?' matches 'c', but the second letter is 'a', which does not
# match 'b'.
#
# Example 4:
#
# Input:
# s = "adceb"
# p = "*a*b"
# Output: true
# Explanation: The first '*' matches the empty sequence, while the second '*'
# matches the substring "dce".
#
# Example 5:
#
# Input:
# s = "acdcb"
# p = "a*c?b"
# Output: false


# See problem 10.
# Recursive.

# @param {String} s
# @param {String} p
# @return {Boolean}
def is_match(s, p, i=0, j=0)
  return i == s.length if j == p.length
  return false if i > s.length
  if p[j] == '*'
    is_match(s, p, i, j+1) || is_match(s, p, i+1, j)
  elsif p[j] == '?' || s[i] == p[j]
    is_match(s, p, i+1, j+1)
  else
    false
  end
end


# DP.
#
#   1. d[i][j]: is_match(s[i..-1], p[j..-1]).
#   2. d[m][n] = true: is_match("", "")
#   3. d[m][j] only maches pattern like this: "***...***".
#   4. d[i][j]:
#      - p[j] == '*':
#        - we can ignore '*' and see if rest of the pattern still match.
#        - we can use one character or more characters in s by moving to next character in s.
#      - p[j] == '?' or p[j] == s[i]
#        move to the next character in s and p.
#      - otherwise they do not match.

def is_match(s, p)
  m, n = s.size, p.size
  d = Array.new(m+1) { Array.new(n+1, false) }
  d[m][n] = true
  m.downto(0).each do |i|
    (n-1).downto(0).each do |j|
      if i == m
        d[i][j] = p[j] == '*' && d[i][j+1]
      elsif p[j] == '*'
        d[i][j] = d[i][j+1] || d[i+1][j]
      elsif p[j] == '?' || s[i] == p[j]
        d[i][j] = d[i+1][j+1]
      end
    end
  end
  d[0][0]
end
