# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=130 lang=ruby
#
# [130] Surrounded Regions
#
# https://leetcode.com/problems/surrounded-regions/description/
#
# Given a 2D board containing 'X' and 'O' (the letter O), capture all
# regions surrounded by 'X'.
#
# A region is captured by flipping all 'O's into 'X's in that
# surrounded region.
#
# Example:
#
# X X X X
# X O O X
# X X O X
# X O X X
#
# After running your function, the board should be:
#
# X X X X
# X X X X
# X X X X
# X O X X
#
# Explanation:
#
# Surrounded regions shouldn’t be on the border, which means that any
# 'O' on the border of the board are not flipped to 'X'. Any 'O' that
# is not on the border and it is not connected to an 'O' on the border
# will be flipped to 'X'. Two cells are connected if they are adjacent
# cells connected horizontally or vertically.


# Using Union-Find, the idea is simple
#
#   1. Union all the 'O's together.
#   2. Union all 'O's on border to a dummy-node.
#   3. Flip all 'O's to 'X's which are not connected to the dummy-node.

# @param {Character[][]} board
# @return {Void} Do not return anything, modify board in-place instead.
def solve_a(board)
  return if board.empty?
  w, h = board[0].length, board.length
  uf = UF.new(w*h+1)
  dummy_node = w*h
  region = []
  (0...(w*h)).each do |i|
    if board[i/w][i%w] == 'O'
      region << i
      neighbors = []
      neighbors << i+1 unless ((i+1) % w).zero?
      neighbors << i-1 unless (i % w).zero?
      neighbors << i-w unless i >= 0 && i < w
      neighbors << i+w unless i >= w*(h-1) && i < w*h
      uf.union(i, dummy_node) unless neighbors.length == 4
      neighbors.each do |n|
        uf.union(n, i) if board[n/w][n%w] == 'O'
      end
    end
  end
  region.each do |i|
    board[i/w][i%w] = 'X' unless uf.connected?(i, dummy_node)
  end
end

class UF
  def initialize(size)
    @arr = Array.new(size, &:itself)
    @weight = Array.new(size, 1)
  end

  def connected?(p, q)
    root(p) == root(q)
  end

  def root(p)
    until p == @arr[p]
      @arr[p] = @arr[@arr[p]]
      p = @arr[p]
    end
    p
  end

  def union(p, q)
    i, j = root(p), root(q)
    return if i == j
    if @weight[i] < @weight[j]
      @arr[i] = j
      @weight[j] += @weight[i]
    else
      @arr[j] = i
      @weight[i] += @weight[j]
    end
  end

  def max_size
    @weight.max
  end
end


# Another approach is using search, the idea is also simple:
#
#   1. Search through all 'O's on border and mark them as '*'.
#   2. Flip all 'O's to 'X' since it's not connected to border.
#   3. Flip all '*'s back to 'O'.

def solve(board)
  return if board.empty?
  w, h = board[0].length, board.length
  (0...w).each do |j|
    search(board, 0, j)
    search(board, h-1, j)
  end
  (0...h).each do |i|
    search(board, i, 0)
    search(board, i, w-1)
  end
  (0...h).each do |i|
    (0...w).each do |j|
      board[i][j] = 'X' if board[i][j] == 'O'
      board[i][j] = 'O' if board[i][j] == '*'
    end
  end
end

def search(board, i, j)
  return if i < 0 || i > board.length-1 ||
    j < 0 || j > board[0].length-1 ||
    board[i][j] == 'X' || board[i][j] == '*'
  board[i][j] = '*'
  search(board, i-1, j) # up
  search(board, i+1, j) # down
  search(board, i, j-1) # left
  search(board, i, j+1) # right
end
