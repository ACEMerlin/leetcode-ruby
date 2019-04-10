# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=947 lang=ruby
#
# [947] Most Stones Removed with Same Row or Column
#
# https://leetcode.com/problems/most-stones-removed-with-same-row-or-column/description/
#
# On a 2D plane, we place stones at some integer coordinate points.
# Each coordinate point may have at most one stone.
#
# Now, a move consists of removing a stone that shares a column or row
# with another stone on the grid.
#
# What is the largest possible number of moves we can make?
#
# Example 1:
#
# Input: stones = [[0,0],[0,1],[1,0],[1,2],[2,1],[2,2]]
# Output: 5
#
# Example 2:
#
# Input: stones = [[0,0],[0,2],[1,1],[2,0],[2,2]]
# Output: 3
#
# Example 3:
#
# Input: stones = [[0,0]]
# Output: 0
#
# Note:
#
# 1 <= stones.length <= 1000
# 0 <= stones[i][j] < 10000


# Same as problem 200.

# Union Find.

# @param {Integer[][]} stones
# @return {Integer}
def remove_stones_a(stones)
  g = stones.each_with_index.reduce({}) { |h, (s, i)| h[s] = i; h }
  xs = stones.reduce(Hash.new { |h, k| h[k] = [] }) { |h, s| h[s[0]] << s; h }
  ys = stones.reduce(Hash.new { |h, k| h[k] = [] }) { |h, s| h[s[1]] << s; h }
  uf = UF.new(stones.size)
  stones.each do |s|
    (xs[s[0]]+ys[s[1]]).each { |k| uf.union(g[s], g[k]) }
  end
  stones.size - uf.ans
end

class UF

  def initialize(size)
    @arr = Array.new(size, &:itself)
    @weight = Array.new(size, 1)
  end

  def union(i, j)
    p, q = root(i), root(j)
    return if p == q
    if @weight[p] < @weight[q]
      @arr[p] = q
      @weight[q] += @weight[p]
    else
      @arr[q] = p
      @weight[p] += @weight[q]
    end
  end

  def connected?(i, j)
    root(i) == root(j)
  end

  def ans
    @arr.map { |i| root(i) }.uniq.count
  end

  private

  def root(i)
    while @arr[i] != i
      @arr[i] = @arr[@arr[i]]
      i = @arr[i]
    end
    i
  end
end


# DFS. Sink the islands.

def remove_stones(stones)
  xs = stones.reduce(Hash.new { |h, k| h[k] = [] }) { |h, s| h[s[0]] << s; h }
  ys = stones.reduce(Hash.new { |h, k| h[k] = [] }) { |h, s| h[s[1]] << s; h }
  count = 0
  stones.each do |k|
    next if k == [-1, -1]
    dfs(xs, ys, k)
    count += 1
  end
  stones.size - count
end

def dfs(xs, ys, k)
  return if k == [-1, -1]
  x, y = k
  k[0], k[1] = -1, -1
  (xs[x]+ys[y]).each do |s|
    dfs(xs, ys, s)
  end
end
