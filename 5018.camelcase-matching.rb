# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=5018 lang=ruby
#
# [5018] Camelcase Matching
#
# https://leetcode.com/problems/camelcase-matching/description/
#
# A query word matches a given pattern if we can insert lowercase
# letters to the pattern word so that it equals the query. (We may
# insert each character at any position, and may insert 0 characters.)
#
# Given a list of queries, and a pattern, return an answer list of booleans,
# where answer[i] is true if and only if queries[i] matches the pattern.
#
# Example 1:
#
# Input: queries =
# ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FB"
# Output: [true,false,true,true,false]
# Explanation:
# "FooBar" can be generated like this "F" + "oo" + "B" + "ar".
# "FootBall" can be generated like this "F" + "oot" + "B" + "all".
# "FrameBuffer" can be generated like this "F" + "rame" + "B" + "uffer".
#
# Example 2:
#
# Input: queries =
# ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FoBa"
# Output: [true,false,true,false,false]
# Explanation:
# "FooBar" can be generated like this "Fo" + "o" + "Ba" + "r".
# "FootBall" can be generated like this "Fo" + "ot" + "Ba" + "ll".
#
# Example 3:
#
# Input: queries =
# ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FoBaT"
# Output: [false,true,false,false,false]
# Explanation:
# "FooBarTest" can be generated like this "Fo" + "o" + "Ba" + "r" + "T" + "est".
#
# Note:
#
# 1 <= queries.length <= 100
# 1 <= queries[i].length <= 100
# 1 <= pattern.length <= 100
# All strings consists only of lower and upper case English letters.


# Should be an 'easy' problem.

# @param {String[]} queries
# @param {String} pattern
# @return {Boolean[]}
def camel_match(queries, pattern)
  queries.map { |q| match?(q, pattern) }
end

def match?(q, p)
  i = j = 0
  while i < q.length
    if q[i] == p[j]
      i += 1
      j += 1
    elsif q[i] >= 'a' && q[i] <= 'z'
      i += 1
    else
      return false
    end
  end
  j == p.length
end
