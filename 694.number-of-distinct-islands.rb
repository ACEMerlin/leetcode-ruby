# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=694 lang=ruby
#
# [694] Number of Distinct Islands
#
# https://leetcode.com/problems/number-of-distinct-islands/description/
#
# Given a non-empty 2D array grid of 0's and 1's, an island is a group
# of 1's (representing land) connected 4-directionally (horizontal or
# vertical.) You may assume all four edges of the grid are surrounded
# by water.
#
# Count the number of distinct islands. An island is considered to be
# the same as another if and only if one island can be translated (and
# not rotated or reflected) to equal the other.
#
# Example:
#
# 11011
# 10000
# 00001
# 11011
# Given the above grid map, return 3.
# Notice that:
# 11
# 1
# and
#  1
# 11
# are considered different island shapes, because we do not consider
# reflection / rotation.
#
# Note: The length of each dimension in the given grid does not exceed 50.


# See problem 200.

# Ruby Set/Hash can use mutable types (e.g. lists) as keys. Key
# observation is that we always enter at the same point for two same
# shape islands, and the dfs paths would also be the same.

def num_distinct_islands(grid)
  w, h = grid[0].size, grid.size
  shapes = Set.new
  (0...h).each do |i|
    (0...w).each do |j|
      next if grid[i][j] == 0
      shape = dfs(grid, i, j)
      shapes << shape if !shape.empty?
    end
  end
  shapes.size
end

def dfs(grid, i, j, p=0, q=0, shape=[])
  return if i < 0 || i > grid.size-1 ||
    j < 0 || j > grid[0].size-1 || grid[i][j] == 0
  grid[i][j] = 0
  shape << [p, q]
  dfs(grid, i-1, j, p-1, q, shape)
  dfs(grid, i+1, j, p+1, q, shape)
  dfs(grid, i, j-1, p, q-1, shape)
  dfs(grid, i, j+1, p, q+1, shape)
  shape
end
