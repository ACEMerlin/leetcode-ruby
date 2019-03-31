# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=5 lang=ruby
#
# [5] Longest Palindromic Substring
#
# https://leetcode.com/problems/longest-palindromic-substring/description/
#
# Given a string s, find the longest palindromic substring in s. You
# may assume that the maximum length of s is 1000.
#
# Example 1:
#
# Input: "babad"
# Output: "bab"
# Note: "aba" is also a valid answer.
#
# Example 2:
#
# Input: "cbbd"
# Output: "bb"


# "cacbbcb": find all segment with the same character.
#   "c" "a" "c" "bb" "c" "b" expand each segment:
#   "c" "cac" "c" "cbbc" "bcb" "b"
# we have cbbc as longest palindrome.

# @param {String} s
# @return {String}
def longest_palindrome(s)
  longest = ""
  i = 0
  while i < s.length
    j = i + 1
    j += 1 while s[j] == s[i]
    found = expand(s, i, j-1)
    longest = found if found.length >= longest.length
    i = j
  end
  longest
end

def expand(s, l, r)
  while l >= 0 && r < s.length && s[l] == s[r]
    l -= 1
    r += 1
  end
  s[(l+1)..(r-1)]
end
