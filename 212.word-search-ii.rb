# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=212 lang=ruby
#
# [212] Word Search II
#
# https://leetcode.com/problems/word-search-ii/description/
#
# Given a 2D board and a list of words from the dictionary, find all
# words in the board.
#
# Each word must be constructed from letters of sequentially adjacent
# cell, where "adjacent" cells are those horizontally or vertically
# neighboring. The same letter cell may not be used more than once in
# a word.
#
# Example:
#
# Input:
# board = [
# ⁠ ['o','a','a','n'],
# ⁠ ['e','t','a','e'],
# ⁠ ['i','h','k','r'],
# ⁠ ['i','f','l','v']
# ]
# words = ["oath","pea","eat","rain"]
#
# Output: ["eat","oath"]
#
# Note:
#
# All inputs are consist of lowercase letters a-z. The values of words
# are distinct.


# DFS+Backtracking+Trie.

# @param {Character[][]} board
# @param {String[]} words
# @return {String[]}
def find_words(board, words)
  trie, ans = build_trie(words), []
  board.each_with_index do |r, i|
    r.each_with_index do |c, j|
      dfs(board, trie, i, j, ans)
    end
  end
  ans
end

def dfs(g, t, i, j, ans)
  return if i < 0 || i > g.size-1 ||
    j < 0 || j > g[0].size-1
  t = t.next[g[i][j]]
  return if t.nil?
  ans << t.word and t.word = nil if !t.word.nil?
  g[i][j], x = "*", g[i][j]
  dfs(g, t, i-1, j, ans)
  dfs(g, t, i+1, j, ans)
  dfs(g, t, i, j-1, ans)
  dfs(g, t, i, j+1, ans)
  g[i][j] = x
end

def build_trie(words)
  root = Trie.new
  words.each do |w|
    cur = root
    w.each_char do |c|
      cur.next[c] = Trie.new if !cur.next.has_key?(c)
      cur = cur.next[c]
    end
    cur.word = w
  end
  root
end

class Trie
  attr_accessor :word, :next
  def initialize
    @word, @next = nil, {}
  end
end
