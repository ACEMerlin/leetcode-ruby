# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=79 lang=ruby
#
# [79] Word Search
#
# https://leetcode.com/problems/word-search/description/
#
# Given a 2D board and a word, find if the word exists in the grid.
#
# The word can be constructed from letters of sequentially adjacent
# cell, where "adjacent" cells are those horizontally or vertically
# neighboring. The same letter cell may not be used more than once.
#
# Example:
#
# board =
# [
# ⁠ ['A','B','C','E'],
# ⁠ ['S','F','C','S'],
# ⁠ ['A','D','E','E']
# ]
#
# Given word = "ABCCED", return true.
# Given word = "SEE", return true.
# Given word = "ABCB", return false.


# When I use Array.new(board.size) { Array.new(board[0].size, false) }
# as a default parameter, the runtime bumps up to 4000ms, WTF RUBY, not cool.

# DFS+Backtracking.

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  board.each_with_index do |b, i|
    b.each_with_index do |c, j|
      return true if dfs(board, word, i, j, 0)
    end
  end
  false
end

def dfs(g, word, i, j, k)
  return true if k == word.size
  return false if i < 0 || i > g.size-1 ||
    j < 0 || j > g[0].size-1 ||
    g[i][j] != word[k]
  g[i][j], x = "*", g[i][j]
  ans = dfs(g, word, i-1, j, k+1) ||
    dfs(g, word, i+1, j, k+1) ||
    dfs(g, word, i, j-1, k+1) ||
    dfs(g, word, i, j+1, k+1)
  g[i][j] = x
  ans
end
