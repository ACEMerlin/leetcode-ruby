# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=63 lang=ruby
#
# [63] Unique Paths II
#
# https://leetcode.com/problems/unique-paths-ii/description/
#
# A robot is located at the top-left corner of a m x n grid (marked
# 'Start' in the diagram below).
#
# The robot can only move either down or right at any point in time.
# The robot is trying to reach the bottom-right corner of the grid
# (marked 'Finish' in the diagram below).
#
# Now consider if some obstacles are added to the grids. How many
# unique paths would there be?
#
# An obstacle and empty space is marked as 1 and 0 respectively in the grid.
#
# Note: m and n will be at most 100.
#
# Example 1:
#
# Input:
# [
# [0,0,0],
# [0,1,0],
# [0,0,0]
# ]
# Output: 2
# Explanation:
# There is one obstacle in the middle of the 3x3 grid above.
# There are two ways to reach the bottom-right corner:
# 1. Right -> Right -> Down -> Down
# 2. Down -> Down -> Right -> Right


# Recursive Version.

# @param {Integer[][]} obstacle_grid
# @return {Integer}
def unique_paths_with_obstacles_a(obstacle_grid)
  dfs(obstacle_grid)
end

def dfs(g, i=0, j=0, memo={})
  return memo[[i, j]] if memo.has_key?([i, j])
  return 0 if i == g.size || j == g[0].size || g[i][j] == 1
  return g[i][j] == 1 ? 0 : 1 if i == g.size-1 && j == g[0].size-1
  (dfs(g, i+1, j, memo) + dfs(g, i, j+1, memo)).tap { |r| memo[[i, j]] = r }
end



# DP version.

def unique_paths_with_obstacles(obstacle_grid)
  return 0 if obstacle_grid[0][0] == 1 || obstacle_grid[-1][-1] == 1
  n, m = obstacle_grid.size, obstacle_grid[0].size
  dp = Array.new(n) { Array.new(m, 0) }
  (0...n).each do |i|
    (0...m).each do |j|
      next if obstacle_grid[i][j] == 1
      if i == 0 && j == 0
        dp[i][j] = 1
      else
        dp[i][j] = (i-1 >= 0 ? dp[i-1][j] : 0) + (j-1 >= 0 ? dp[i][j-1] : 0)
      end
    end
  end
  dp[-1][-1]
end
