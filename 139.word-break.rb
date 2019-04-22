# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=139 lang=ruby
#
# [139] Word Break
#
# https://leetcode.com/problems/word-break/description/
#
# Given a non-empty string s and a dictionary wordDict containing a
# list of non-empty words, determine if s can be segmented into a
# space-separated sequence of one or more dictionary words.
#
# Note:
#
# The same word in the dictionary may be reused multiple times in the
# segmentation.
# You may assume the dictionary does not contain duplicate words.
#
# Example 1:
#
# Input: s = "leetcode", wordDict = ["leet", "code"]
# Output: true
# Explanation: Return true because "leetcode" can be segmented as
# "leet code".
#
# Example 2:
#
# Input: s = "applepenapple", wordDict = ["apple", "pen"]
# Output: true
# Explanation: Return true because "applepenapple" can be segmented as
# "apple pen apple". Note that you are allowed to reuse a dictionary
# word.
#
# Example 3:
#
# Input: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]
# Output: false


# Recursion+Memo.

# @param {String} s
# @param {String[]} word_dict
# @return {Boolean}
def word_break(s, word_dict)
  helper(s, word_dict.to_set)
end

def helper(s, word_dict, i=0, memo={})
  return true if i == s.size
  return memo[i] if memo.has_key?(i)
  (i..s.length-1).each do |j|
    if word_dict.include?(s[i..j]) && helper(s, word_dict, j+1, memo)
      return memo[i] = true
    end
  end
  memo[i] = false
end


# DP.
#
#   1. dp[i]: we can break s[i..-1].
#   2. if dp[j] is true and s[i..j-1] is in word_dict, then dp[i] is true.
#   3. dp[n] is true, just like `i == size` in recursion.
#   3. dp[0] needs to be true.

def word_break(s, word_dict)
  n = s.size
  dp = Array.new(n+1, false)
  dp[n] = true
  (n-1).downto(0).each do |i|
    (i+1..n).each do |j|
      if dp[j] && word_dict.include?(s[i..j-1])
        dp[i] = true
        break
      end
    end
  end
  dp[0]
end
