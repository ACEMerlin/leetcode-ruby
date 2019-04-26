# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=72 lang=ruby
#
# [72] Edit Distance
#
# https://leetcode.com/problems/edit-distance/description/
#
# Given two words word1 and word2, find the minimum number of
# operations required to convert word1 to word2.
#
# You have the following 3 operations permitted on a word:
#
# Insert a character
# Delete a character
# Replace a character
#
# Example 1:
#
# Input: word1 = "horse", word2 = "ros"
# Output: 3
# Explanation:
# horse -> rorse (replace 'h' with 'r')
# rorse -> rose (remove 'r')
# rose -> ros (remove 'e')
#
# Example 2:
#
# Input: word1 = "intention", word2 = "execution"
# Output: 5
# Explanation:
# intention -> inention (remove 't')
# inention -> enention (replace 'i' with 'e')
# enention -> exention (replace 'n' with 'x')
# exention -> exection (replace 'n' with 'c')
# exection -> execution (insert 'u')


# DP. O(n^2).
#
#   0. m: length of word1. n: length of word2.
#   1. d[i][j]: subproblem for word1[i..-1] and word2[j..-1].
#   2. d[m][j] is n-j, cuz the cost of converting an empty string to
#      another string is the length of that string which is n-j. Same
#      with d[i][n]: m-i.
#   3. insert: d[i][j+1]; delete: d[i+1][j]; replace: d[i+1][j+1].
#   4. The answer is d[0][0].

# @param {String} word1
# @param {String} word2
# @return {Integer}
def min_distance(word1, word2)
  m, n = word1.size, word2.size
  d = Array.new(m+1) { Array.new(n+1, 0) }
  m.downto(0) do |i|
    n.downto(0) do |j|
      if i == m
        d[i][j] = n-j
      elsif j == n
        d[i][j] = m-i
      elsif word1[i] == word2[j]
        d[i][j] = d[i+1][j+1]
      else
        d[i][j] = [d[i][j+1], d[i+1][j], d[i+1][j+1]].min + 1
      end
    end
  end
  d[0][0]
end
