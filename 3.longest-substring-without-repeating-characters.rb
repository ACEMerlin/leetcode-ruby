# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=3 lang=ruby
#
# [3] Longest Substring Without Repeating Characters
#
# https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
#
# Given a string, find the length of the longest substring without
# repeating characters.
#
# Example 1:
#
# Input: "abcabcbb"
# Output: 3
# Explanation: The answer is "abc", with the length of 3.
#
# Example 2:
#
# Input: "bbbbb"
# Output: 1
# Explanation: The answer is "b", with the length of 1.
#
# Example 3:
#
# Input: "pwwkew"
# Output: 3
# Explanation: The answer is "wke", with the length of 3. ⁠ Note that
# the answer must be a substring, "pwke" is a subsequence and not a
# substring.


# The key is to keep a sliding window of substring without repeating
# characters. Example:
#
# given "abcab"
#  a b c a b | "a"      | 1 | { a: 0 }
# / \
#i   j
#  a b c a b | "ab"     | 2 | { a: 0, b: 1 }
#  | |
#  j i
#  a b c a b | "abc"    | 3 | { a: 0, b: 1, c: 2 }
#  |   |
#  j   i
#  a b c a b | "bac"    | 3 | { a: 3, b: 1, c: 2 }
#    |   |
#    j   i
#  a b c a b | "cab"    | 3 | { a: 3, b: 4, c: 2 }
#      |   |
#      j   i
#
# max: 3

# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  result = 0
  hash = {}
  j = 0
  for i in 0...s.length
    if hash.has_key?(s[i])
      j = [hash[s[i]]+1, j].max
    end
    result = [i-j+1, result].max
    hash[s[i]] = i
  end
  result
end
