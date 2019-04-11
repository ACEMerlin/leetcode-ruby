# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=460 lang=ruby
#
# [460] LFU Cache
#
# https://leetcode.com/problems/lfu-cache/description/
#
# Design and implement a data structure for Least Frequently Used
# (LFU) cache. It should support the following operations: get and put.
#
# get(key) - Get the value (will always be positive) of the key if the key
# exists in the cache, otherwise return -1.
# put(key, value) - Set or insert the value if the key is not already present.
# When the cache reaches its capacity, it should invalidate the least
# frequently used item before inserting a new item. For the purpose of this
# problem, when there is a tie (i.e., two or more keys that have the same
# frequency), the least recently used key would be evicted.
#
# Follow up: Could you do both operations in O(1) time complexity?
#
# Example:
#
# LFUCache cache = new LFUCache( 2 /* capacity */ );
#
# cache.put(1, 1);
# cache.put(2, 2);
# cache.get(1);       // returns 1
# cache.put(3, 3);    // evicts key 2
# cache.get(2);       // returns -1 (not found)
# cache.get(3);       // returns 3.
# cache.put(4, 4);    // evicts key 1.
# cache.get(1);       // returns -1 (not found)
# cache.get(3);       // returns 3
# cache.get(4);       // returns 4


# See problem 146. Just read the code, pretty straigth forward, I ACed
# in one go.
#
#   - DDL: doubly linked list.
#   - min: min frequency of current elements.
#   - freq: { freq:ddl }.
#   - h: { key:node }.

class LFUCache

  def initialize(capacity)
    @cap, @min = capacity, 0
    @freq, @h = Hash.new { |h, k| h[k] = DDL.new }, {}
  end

  def get(key)
    return -1 if !@h.has_key?(key)
    update(@h[key])
    @h[key].val
  end

  def put(key, value)
    return if @cap == 0
    if @h.has_key?(key)
      update(@h[key])
      @h[key].val = value
    else
      @h.delete(@freq[@min].pop.key) if @h.size == @cap
      node = Node.new(key, value)
      @h[key] = node
      @freq[0].unshift(node)
      @min = 0
    end
  end

  private

  def update(node)
    @freq[node.freq].delete(node)
    @min += 1 if @min == node.freq && @freq[node.freq].empty?
    node.freq += 1
    @freq[node.freq].unshift(node)
  end

  class Node
    attr_accessor :key, :val, :freq, :next, :prev
    def initialize(key, val)
      @key, @val = key, val
      @freq, @next, @prev = 0, nil, nil
     end
  end

  class DDL

    def initialize
      @last = Node.new(nil, nil)
      @first = Node.new(nil, nil)
      @last.prev = @first
      @first.next = @last
    end

    def unshift(node)
      t = @first.next
      @first.next = node
      node.prev = @first
      t.prev = node
      node.next = t
    end

    def delete(node)
      node.prev.next = node.next
      node.next.prev = node.prev
    end

    def pop
      x = last
      delete(last)
      x
    end

    def first
      @first.next
    end

    def last
      @last.prev
    end

    def empty?
      @first.next == @last
    end
  end
end
