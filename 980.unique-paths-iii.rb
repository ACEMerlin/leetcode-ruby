# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=980 lang=ruby
#
# [980] Unique Paths III
#
# https://leetcode.com/problems/unique-paths-iii/description/
#
# On a 2-dimensional grid, there are 4 types of squares:
#
# 1 represents the starting square. There is exactly one starting square.
# 2 represents the ending square. There is exactly one ending square.
# 0 represents empty squares we can walk over.
# -1 represents obstacles that we cannot walk over.
#
#
# Return the number of 4-directional walks from the starting square to the
# ending square, that walk over every non-obstacle square exactly once.
#
# Example 1:
#
# Input: [[1,0,0,0],[0,0,0,0],[0,0,2,-1]]
# Output: 2
# Explanation: We have the following two paths:
# 1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2)
# 2. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2)
#
# Example 2:
#
# Input: [[1,0,0,0],[0,0,0,0],[0,0,0,2]]
# Output: 4
# Explanation: We have the following four paths:
# 1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2),(2,3)
# 2. (0,0),(0,1),(1,1),(1,0),(2,0),(2,1),(2,2),(1,2),(0,2),(0,3),(1,3),(2,3)
# 3. (0,0),(1,0),(2,0),(2,1),(2,2),(1,2),(1,1),(0,1),(0,2),(0,3),(1,3),(2,3)
# 4. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2),(2,3)
#
#
# Example 3:
#
# Input: [[0,1],[2,0]]
# Output: 0
# Explanation:
# There is no path that walks over every empty square exactly once.
# Note that the starting and ending square can be anywhere in the grid.
#
# Note:
#
# 1 <= grid.length * grid[0].length <= 20


# See problem 200, same idea.

# DFS from start point, 'sink' all 0 by changing it to '-1', keep
# record of the number of 0s we have meet, add current path when
# reaching '2' and current count equals to the number of '0's in the
# grid, flip '-1' back to '0' on the way back.

# @param {Integer[][]} grid
# @return {Integer}
def unique_paths_iii(grid)
  w, h, length = grid[0].size, grid.size, 1
  x = y = 0
  (0...h).each do |i|
    (0...w).each do |j|
      x, y = i, j if grid[i][j] == 1
      length += 1 if grid[i][j] == 0
    end
  end
  search(grid, x, y, length)
end

def search(grid, i, j, length, ans=[0])
  return if i < 0 || i > grid.length-1 ||
    j < 0 || j > grid[0].length-1 ||
    grid[i][j] == -1
  if grid[i][j] == 2
    ans[0] += 1 if length == 0
    return
  end
  grid[i][j] = -1
  search(grid, i+1, j, length-1, ans)
  search(grid, i-1, j, length-1, ans)
  search(grid, i, j+1, length-1, ans)
  search(grid, i, j-1, length-1, ans)
  grid[i][j] = 0
  ans[0]
end
