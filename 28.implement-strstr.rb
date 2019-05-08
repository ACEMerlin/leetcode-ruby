# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=28 lang=ruby
#
# [28] Implement strStr()
#
# https://leetcode.com/problems/implement-strstr/description/
#
# Implement strStr().
#
# Return the index of the first occurrence of needle in haystack, or
# -1 if needle is not part of haystack.
#
# Example 1:
#
# Input: haystack = "hello", needle = "ll"
# Output: 2
#
# Example 2:
#
# Input: haystack = "aaaaa", needle = "bba"
# Output: -1
#
# Clarification:
#
# What should we return when needle is an empty string? This is a
# great question to ask during an interview.
#
# For the purpose of this problem, we will return 0 when needle is an empty
# string. This is consistent to C's strstr() and Java's indexOf().


# Ruby.

# @param {String} haystack
# @param {String} needle
# @return {Integer}
def str_str(haystack, needle)
  needle.empty? ? 0 : haystack.index(needle) || -1
end


# Brute Force.

def str_str(haystack, needle)
  return 0 if needle.empty?
  return -1 if needle.length > haystack.length
  m, n = haystack.size, needle.size
  (0..m-n).each do |i|
    j, k = i, 0
    while j < m &&
        k < n &&
        haystack[j] == needle[k]
      j += 1
      k += 1
    end
    return i if k == n
  end
  -1
end


# TODO
#   - KMP.
#   - Rabin-Karp.
#   - Boyer-Moore.
