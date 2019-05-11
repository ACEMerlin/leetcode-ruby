# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=131 lang=ruby
#
# [131] Palindrome Partitioning
#
# https://leetcode.com/problems/palindrome-partitioning/description/
#
# Given a string s, partition s such that every substring of the
# partition is a palindrome.
#
# Return all possible palindrome partitioning of s.
#
# Example:
#
# Input: "aab"
# Output:
# [
# ⁠ ["aa","b"],
# ⁠ ["a","a","b"]
# ]


# DFS.

# @param {String} s
# @return {String[][]}
def partition(s)
  dfs(s, 0)
end

def dfs(s, k, path=[], paths=[])
  return if k > s.size
  if k == s.size
    paths << path.dup
  else
    (k..s.size-1).each do |i|
      next if !pl?(s[k..i])
      path << s[k..i]
      dfs(s, i+1, path, paths)
      path.pop
    end
  end
  paths
end

def pl?(s)
  i, j = 0, s.size-1
  while i < j
    return false if s[i] != s[j]
    i += 1
    j -= 1
  end
  true
end


# Recursive.

def partition(s, k=0)
  return [[]] if k == s.size
  (k..s.size-1).flat_map do |i|
    pl?(s[k..i]) ? partition(s, i+1).map { |r| [s[k..i]]+r } : []
  end
end
