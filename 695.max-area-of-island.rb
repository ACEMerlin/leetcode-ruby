# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=695 lang=ruby
#
# [695] Max Area of Island
#
# https://leetcode.com/problems/max-area-of-island/description/
#
# Given a non-empty 2D array grid of 0's and 1's, an island is a group
# of 1's (representing land) connected 4-directionally (horizontal or
# vertical.) You may assume all four edges of the grid are surrounded
# by water.
#
# Find the maximum area of an island in the given 2D array. (If there
# is no island, the maximum area is 0.)
#
# Example 1:
#
# [[0,0,1,0,0,0,0,1,0,0,0,0,0],
# ⁠[0,0,0,0,0,0,0,1,1,1,0,0,0],
# ⁠[0,1,1,0,1,0,0,0,0,0,0,0,0],
# ⁠[0,1,0,0,1,1,0,0,1,0,1,0,0],
# ⁠[0,1,0,0,1,1,0,0,1,1,1,0,0],
# ⁠[0,0,0,0,0,0,0,0,0,0,1,0,0],
# ⁠[0,0,0,0,0,0,0,1,1,1,0,0,0],
# ⁠[0,0,0,0,0,0,0,1,1,0,0,0,0]]
#
# Given the above grid, return 6. Note the answer is not 11, because the island
# must be connected 4-directionally.
#
# Example 2:
#
# [[0,0,0,0,0,0,0,0]]
# Given the above grid, return 0.
#
# Note: The length of each dimension in the given grid does not exceed 50.



# See problem 200, it's the same idea
# Using Union-Find, the idea is simple
#   1. union all the '1's together
#   2. count the size of each connected component
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

# @param {Integer[][]} grid
# @return {Integer}
def max_area_of_island_a(grid)
  return 0 if grid.empty?
  w, h = grid[0].length, grid.length
  uf = UF.new(w*h)
  islands = []
  (0...w*h).each do |i|
    if grid[i/w][i%w] == 1
      islands << i
      neighbors = []
      neighbors << i+1 unless ((i+1) % w).zero?
      neighbors << i-1 unless (i % w).zero?
      neighbors << i-w unless i >= 0 && i < w
      neighbors << i+w unless i >= w*(h-1) && i < w*h
      neighbors.each do |n|
        uf.union(n, i) if grid[n/w][n%w] == 1
      end
    end
  end
  freq = Hash.new(0)
  islands.map { |i| uf.root(i) }.each { |i| freq[i] += 1 }
  freq.values.max || 0
end



# Using search, the idea is also simple:
#   1. search through all '1's in a single connected component, that's one island, and return count of 1s in each connected component
#   2. mark searched island as marked, we can do this by changing it to 0
#   3. iterate through all components and keep record of the max value
def max_area_of_island(grid)
  return 0 if grid.empty?
  w, h = grid[0].length, grid.length
  max = 0
  (0...h).each do |i|
    (0...w).each do |j|
      if grid[i][j] == 1
        max = [max, search(grid, i, j)].max
      end
    end
  end
  max
end

def search(grid, i, j)
  return 0 if i < 0 || i > grid.length-1 ||
    j < 0 || j > grid[0].length-1 ||
    grid[i][j] == 0
  grid[i][j] = 0
  1 + search(grid, i-1, j) +
    search(grid, i+1, j) +
    search(grid, i, j-1) +
    search(grid, i, j+1)
end
