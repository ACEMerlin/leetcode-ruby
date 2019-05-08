# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=14 lang=ruby
#
# [14] Longest Common Prefix
#
# https://leetcode.com/problems/longest-common-prefix/description/
#
# Write a function to find the longest common prefix string amongst an
# array of strings.
#
# If there is no common prefix, return an empty string "".
#
# Example 1:
#
# Input: ["flower","flow","flight"]
# Output: "fl"
#
# Example 2:
#
# Input: ["dog","racecar","car"]
# Output: ""
# Explanation: There is no common prefix among the input strings.
#
# Note:
#
# All given inputs are in lowercase letters a-z.


# Reduce: (lcp(lcp(lcp(s1, s2), s3), s4)...

# @param {String[]} strs
# @return {String}
def longest_common_prefix(strs)
  f, *strs = strs
  strs.reduce(f) do |r, s|
    return "" if r == ""
    j = 0
    m = [r.size, s.size].min
    j += 1 while j < m && r[j] == s[j]
    j == 0 ? "" : s[0..j-1]
  end
end


# Divide and Conquer.

def longest_common_prefix(strs, lo=0, hi=strs.size-1)
  return "" if strs.empty?
  return strs[lo] if lo == hi
  m = (lo+hi)/2
  lcp(longest_common_prefix(strs, lo, m), longest_common_prefix(strs, m+1, hi))
end

def lcp(s1, s2)
  m = [s1.size, s2.size].min
  j = 0
  j += 1 while j < m && s1[j] == s2[j]
  j == 0 ? "" : s[0..j-1]
end
