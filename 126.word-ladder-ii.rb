# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=126 lang=ruby
#
# [126] Word Ladder II
#
# https://leetcode.com/problems/word-ladder-ii/description/
#
# Given two words (beginWord and endWord), and a dictionary's word
# list, find all shortest transformation sequence(s) from beginWord to
# endWord, such that:
#
# Only one letter can be changed at a time Each transformed word must
# exist in the word list. Note that beginWord is not a transformed
# word.
#
# Note:
#
# Return an empty list if there is no such transformation sequence.
# All words have the same length.
# All words contain only lowercase alphabetic characters.
# You may assume no duplicates in the word list.
# You may assume beginWord and endWord are non-empty and are not the same.
#
# Example 1:
#
# Input:
# beginWord = "hit",
# endWord = "cog",
# wordList = ["hot","dot","dog","lot","log","cog"]
#
# Output:
# [
# ⁠ ["hit","hot","dot","dog","cog"],
# ["hit","hot","lot","log","cog"]
# ]
#
# Example 2:
#
# Input:
# beginWord = "hit"
# endWord = "cog"
# wordList = ["hot","dot","dog","lot","log"]
#
# Output: []
#
# Explanation: The endWord "cog" is not in wordList, therefore no possible
# transformation.


# BFS+DFS.

# @param {String} begin_word
# @param {String} end_word
# @param {String[]} word_list
# @return {String[][]}
def find_ladders(begin_word, end_word, word_list)
  word_list = word_list.to_set
  return 0 if !word_list.include?(end_word)
  q, p = [begin_word], Hash.new { |h, k| h[k] = Set.new }
  found = false
  word_list.delete(begin_word)
  while !q.empty? && !found
    seen = Set.new
    q.size.times do
      x = q.shift
      x.size.times do |i|
        ('a'..'z').each do |c|
          next if x[i] == c
          w = x[0, i] + c + x[i+1, x.size-i]
          next if !word_list.include?(w)
          found = true if w == end_word
          q << w if !seen.include?(w)
          seen << w
          p[w] << x
        end
      end
    end
    word_list.subtract(seen)
  end
  return [] if !found
  dfs(p, end_word, begin_word)
end

def dfs(p, s, t, path=[s], paths=[])
  if s == t
    paths << path.dup
  else
    p[s].each do |w|
      path.unshift(w)
      dfs(p, w, t, path, paths)
      path.shift
    end
  end
  paths
end
