# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=243 lang=ruby
#
# [243] Shortest Word Distance
#
# https://leetcode.com/problems/shortest-word-distance/description/
#
# Given a list of words and two words word1 and word2, return the
# shortest distance between these two words in the list.
#
# For example,
# Assume that words = ["practice", "makes", "perfect", "coding", "makes"].
# Given word1 = “coding”, word2 = “practice”, return 3.
# Given word1 = "makes", word2 = "coding", return 1.


# This question is so fxxking stupid, what's the point of an O(n)
# solution when there are n queries with the same input and the time
# complexity'd be O(n^2). You should preprocess the words and answer
# each query in O(f(w1)+f(w2)) time where f is the time word occurs.

def shortest_distance(words, word1, word2)
  p = q = -1
  min = Float::INFINITY
  words.each_with_index do |w, i|
    if word1 == w
      p = i
    elsif word2 == w
      q = i
    end
    if p >= 0 && q >= 0
      min = [min, (p-q).abs].min
    end
  end
  min
end
