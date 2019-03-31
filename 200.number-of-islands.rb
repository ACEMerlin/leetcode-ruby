# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=200 lang=ruby
#
# [200] Number of Islands
#
# https://leetcode.com/problems/number-of-islands/description/
#
# Given a 2d grid map of '1's (land) and '0's (water), count the
# number of islands. An island is surrounded by water and is formed by
# connecting adjacent lands horizontally or vertically. You may assume
# all four edges of the grid are all surrounded by water.
#
# Example 1:
#
# Input:
# 11110
# 11010
# 11000
# 00000
#
# Output: 1
#
# Example 2:
#
# Input:
# 11000
# 11000
# 00100
# 00011
#
# Output: 3


# See problem 130, it's the same idea.
#
#   1. Union all the '1's together.
#   2. Count the number of connected components.

# @param {Character[][]} grid
# @return {Integer}
def num_islands_a(grid)
  w, h = grid[0].length, grid.length
  uf = UF.new(w*h)
  islands = []
  (0...w*h).each do |i|
    if grid[i/w][i%w] == '1'
      islands << i
      neighbors = []
      neighbors << i+1 unless ((i+1) % w).zero?
      neighbors << i-1 unless (i % w).zero?
      neighbors << i-w unless i >= 0 && i < w
      neighbors << i+w unless i >= w*(h-1) && i < w*h
      neighbors.each do |n|
        uf.union(n, i) if grid[n/w][n%w] == '1'
      end
    end
  end
  islands.map { |i| uf.root(i) }.uniq.count
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


# Using search, the idea is also simple:
#
#   1. Search through all '1's in a single connected component, that's one island.
#   2. Mark searched island as marked, we can do this by changing it to 0.

def num_islands(grid)
  return 0 if grid.empty?
  w, h = grid[0].length, grid.length
  count = 0
  (0...h).each do |i|
    (0...w).each do |j|
      if grid[i][j] == '1'
        search(grid, i, j)
        count += 1
      end
    end
  end
  count
end

def search(grid, i, j)
  return if i < 0 || i > grid.length-1 ||
    j < 0 || j > grid[0].length-1 ||
    grid[i][j] == '0'
  grid[i][j] = '0'
  search(grid, i-1, j) # up
  search(grid, i+1, j) # down
  search(grid, i, j-1) # left
  search(grid, i, j+1) # right
end
