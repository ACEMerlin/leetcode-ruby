# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=127 lang=ruby
#
# [127] Word Ladder
#
# https://leetcode.com/problems/word-ladder/description/
#
# Given two words (beginWord and endWord), and a dictionary's word
# list, find the length of shortest transformation sequence from
# beginWord to endWord, such that:
#
# Only one letter can be changed at a time. Each transformed word must
# exist in the word list. Note that beginWord is not a transformed
# word.
#
# Note:
#
# Return 0 if there is no such transformation sequence.
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
# Output: 5
# Explanation: As one shortest transformation is "hit" -> "hot" ->
# "dot" -> "dog" -> "cog", return its length 5.
#
# Example 2:
#
# Input:
# beginWord = "hit"
# endWord = "cog"
# wordList = ["hot","dot","dog","lot","log"]
# Output: 0
# Explanation: The endWord "cog" is not in wordList, therefore no
# possible transformation.


# BFS.

# @param {String} begin_word
# @param {String} end_word
# @param {String[]} word_list
# @return {Integer}
def ladder_length(begin_word, end_word, word_list)
  word_list = word_list.to_set
  return 0 if !word_list.include?(end_word)
  q, dist = [begin_word], 0
  while !q.empty?
    dist += 1
    q.size.times do
      x = q.shift
      return dist if x == end_word
      x.size.times do |i|
        o = x[i]
        ('a'..'z').each do |c|
          next if c == o
          x[i] = c
          next if !word_list.include?(x)
          word_list.delete(x)
          q << x.dup
        end
        x[i] = o
      end
    end
  end
  0
end


# Bi-directional BFS.
#
# Always search from the smaller end.

def ladder_length(begin_word, end_word, word_list)
  word_list = word_list.to_set
  return 0 if !word_list.include?(end_word)
  qb, qe, dist = Set[begin_word], Set[end_word], 1
  while !qb.empty? && !qe.empty?
    dist += 1
    temp = Set.new
    qb.each do |x|
      x.size.times do |i|
        ('a'..'z').each do |c|
          w = x[0, i] + c + x[i+1, x.size-i]
          return dist if qe.include?(w)
          next if !word_list.include?(w)
          word_list.delete(w)
          temp << w
        end
      end
    end
    if temp.size < qe.size
      qb = temp
    else
      qb, qe = qe, temp
    end
  end
  0
end
