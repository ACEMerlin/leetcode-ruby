# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=140 lang=ruby
#
# [140] Word Break II
#
# https://leetcode.com/problems/word-break-ii/description/
#
# Given a non-empty string s and a dictionary wordDict containing a
# list of non-empty words, add spaces in s to construct a sentence
# where each word is a valid dictionary word. Return all such possible
# sentences.
#
# Note:
#
# The same word in the dictionary may be reused multiple times in the
# segmentation. You may assume the dictionary does not contain
# duplicate words.
#
# Example 1:
#
# Input:
# s = "catsanddog"
# wordDict = ["cat", "cats", "and", "sand", "dog"]
# Output:
# [
# "cats and dog",
# "cat sand dog"
# ]
#
# Example 2:
#
# Input:
# s = "pineapplepenapple"
# wordDict = ["apple", "pen", "applepen", "pine", "pineapple"]
# Output:
# [
# "pine apple pen apple",
# "pineapple pen apple",
# "pine applepen apple"
# ]
# Explanation: Note that you are allowed to reuse a dictionary word.
#
# Example 3:
#
# Input:
# s = "catsandog"
# wordDict = ["cats", "dog", "sand", "and", "cat"]
# Output:
# []


# See problem 139.

# DFS+DP.

# @param {String} s
# @param {String[]} word_dict
# @return {String[]}
def word_break(s, word_dict)
  dict = word_dict.to_set
  return [] if !breakable?(s, dict)
  dfs(s, dict, 0)
end

def breakable?(s, dict)
  n = s.size
  d = Array.new(n+1, false)
  d[n] = true
  (n-1).downto(0).each do |i|
    (i+1..n).each do |j|
      if d[j] && dict.include?(s[i..j-1])
        d[i] = true
        break
      end
    end
  end
  d[0]
end

def dfs(s, dict, k, path="", paths=[])
  return if k > s.size
  if k == s.size
    paths << path
  else
    (k..s.size-1).each do |i|
      w = s[k..i]
      next if !dict.include?(w)
      dfs(s, dict, i+1, path.empty? ? w : "#{path} #{w}", paths)
    end
  end
  paths
end
