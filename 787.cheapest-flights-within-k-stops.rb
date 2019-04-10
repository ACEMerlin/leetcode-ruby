# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=787 lang=ruby
#
# [787] Cheapest Flights Within K Stops
#
# https://leetcode.com/problems/cheapest-flights-within-k-stops/description/
#
# There are n cities connected by m flights. Each fight starts from
# city u and arrives at v with a price w.
#
# Now given all the cities and flights, together with starting city src and the
# destination dst, your task is to find the cheapest price from src to dst with
# up to k stops. If there is no such route, output -1.
#
# Example 1:
# Input:
# n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
# src = 0, dst = 2, k = 1
# Output: 200
# Explanation:
# The graph looks like this:
#
# The cheapest price from city 0 to city 2 with at most 1 stop costs 200, as
# marked red in the picture.
#
# Example 2:
# Input:
# n = 3, edges = [[0,1,100],[1,2,100],[0,2,500]]
# src = 0, dst = 2, k = 0
# Output: 500
# Explanation:
# The graph looks like this:
#
# The cheapest price from city 0 to city 2 with at most 0 stop costs
# 500, as marked blue in the picture.
#
# Note:
#
# The number of nodes n will be in range [1, 100], with nodes labeled from 0 to n - 1.
# The size of flights will be in range [0, n * (n - 1) / 2].
# The format of each flight will be (src, dst, price).
# The price of each flight will be in the range [1, 10000].
# k is in the range of [0, n - 1].
# There will not be any duplicated flights or self cycles.


# Special case Dijkstra. See problem 743.

# @param {Integer} n
# @param {Integer[][]} flights
# @param {Integer} src
# @param {Integer} dst
# @param {Integer} k
# @return {Integer}
def find_cheapest_price(n, flights, src, dst, k)
  g = flights.reduce(Hash.new { |h, t| h[t] = [] }) { |h, (u, v, w)| h[u] << [v, w]; h }
  q = MinHeap.new.tap { |h| h.push(0, [src, -1, 0]) }
  while !q.empty?
    u, d, c = q.pop
    return c if d <= k && dst == u
    next if d >= k
    g[u].each do |(v, w)|
      alt = c + w
      q.push(alt, [v, d+1, alt])
    end
  end
  -1
end

class MinHeap

  def initialize
    @arr = [nil]
  end

  def push(k, v=k)
    @arr << Node.new(k, v)
    swim(size)
  end

  def pop
    x = @arr[1]
    @arr[1] = @arr[-1]
    @arr.pop
    sink(1)
    x.val
  end

  def size
    @arr.size-1
  end

  def empty?
    size == 0
  end

  def min
    @arr[1]
  end

  def to_s
    @arr[1..-1].to_s
  end

  private

  class Node
    attr_accessor :key, :val
    def initialize(key, val)
      @key, @val = key, val
    end
  end

  def sink(i)
    while 2*i <= size
      j = 2*i
      j += 1 if j < size && @arr[j+1].key < @arr[j].key
      break if @arr[i].key < @arr[j].key
      swap(i, j)
      i = j
    end
  end

  def swim(i)
    while i > 1 && @arr[i].key < @arr[i/2].key
      swap(i, i/2)
      i = i/2
    end
  end

  def swap(i, j)
    @arr[i], @arr[j] = @arr[j], @arr[i]
  end
end
