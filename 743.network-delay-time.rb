# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=743 lang=ruby
#
# [743] Network Delay Time
#
# https://leetcode.com/problems/network-delay-time/description/
#
# There are N network nodes, labelled 1 to N.
#
# Given times, a list of travel times as directed edges times[i] = (u,
# v, w), where u is the source node, v is the target node, and w is
# the time it takes for a signal to travel from source to target.
#
# Now, we send a signal from a certain node K. How long will it take
# for all nodes to receive the signal? If it is impossible, return -1.
#
# Note:
#
# N will be in the range [1, 100].
# K will be in the range [1, N].
# The length of times will be in the range [1, 6000].
# All edges times[i] = (u, v, w) will have 1 <= u, v <= N and 0 <= w <=
# 100.


# Dijkstra. See:
#
#   - https://www.youtube.com/watch?v=2E7MmKv0Y24
#   - https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Using_a_priority_queue
#   - https://stackoverflow.com/questions/9209323/easiest-way-of-using-min-priority-queue-with-key-update-in-c/27305600#27305600

# @param {Integer[][]} times
# @param {Integer} n
# @param {Integer} k
# @return {Integer}
def network_delay_time(times, n, k)
  g = times.reduce(Hash.new { |h, k| h[k] = [] }) { |h, (u, v, w)| h[u] << [v, w]; h }
  dist = Hash.new(Float::INFINITY).tap { |h| h[k] = 0 }
  q = MinHeap.new.tap { |h| h.push(0, k) }
  visited = Set.new
  while !q.empty?
    u = q.pop
    next if visited.include?(u)
    visited << u
    return dist[u] if visited.size == n
    g[u].each do |(v, w)|
      alt = dist[u] + w
      if alt < dist[v]
        dist[v] = alt
        q.push(dist[v], v)
      end
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
