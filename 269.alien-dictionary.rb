# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=269 lang=ruby
#
# [269] Course Schedule II
#
# https://leetcode.com/problems/alien-dictionary/description/
#
# There is a new alien language which uses the latin alphabet.
# However, the order among letters are unknown to you. You receive a
# list of non-empty words from the dictionary, where words are sorted
# lexicographically by the rules of this new language. Derive the
# order of letters in this language.
#
# Example 1:
#
# Given the following words in dictionary,
# [
#   "wrt",
#   "wrf",
#   "er",
#   "ett",
#   "rftt"
# ]
# The correct order is: "wertf".
#
# Example 2:
#
# Given the following words in dictionary,
# [
#   "z",
#   "x"
# ]
# The correct order is: "zx".
#
# Example 3:
#
# Given the following words in dictionary,
# [
#   "z",
#   "x",
#   "z"
# ]
# The order is invalid, so return "".
#
# Note:
#
# You may assume all letters are in lowercase.
# You may assume that if a is a prefix of b, then a must appear before b in the given dictionary.
# If the order is invalid, return an empty string.
# There may be multiple valid order of letters, return any one of them is fine.


# Topological Sort. See https://youtu.be/AfSk24UTFS8?list=PLUl4u3cNGP61Oq3tWYp6V_F-5jb5L2iHb&t=2516

def alien_order(words)
  g = build_graph(words)
  parent, processing, topo = {}, Hash.new(false), []
  g.keys.each do |n|
    if !parent.has_key?(n)
      parent[n] = nil
      return "" if dfs(g, n, parent, processing, topo).nil?
    end
  end
  topo.join
end

def build_graph(words)
  g = Hash.new { |h, k| h[k] = Set.new }
  words.each_cons(2) do |w1, w2|
    p = q = 0
    while p < w1.size && q < w2.size
      a, b = w1[p], w2[q]
      if a != b
        g[a] << b
        break
      else
        p += 1
        q += 1
      end
    end
  end
  g
end

def dfs(g, n, parent, processing, topo)
  processing[n] = true
  g[n].each do |x|
    return if processing[x]
    if !parent.has_key?(x)
      parent[x] = n
      return if dfs(g, x, parent, processing, topo).nil?
    end
  end
  processing[n] = false
  topo.unshift(n)
end
