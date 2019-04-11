# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=146 lang=ruby
#
# [146] LRU Cache
#
# https://leetcode.com/problems/lru-cache/description/
#
# Design and implement a data structure for Least Recently Used (LRU)
# cache. It should support the following operations: get and put.
#
# get(key) - Get the value (will always be positive) of the key if the key
# exists in the cache, otherwise return -1.
# put(key, value) - Set or insert the value if the key is not already present.
# When the cache reached its capacity, it should invalidate the least recently
# used item before inserting a new item.
#
# Follow up:
# Could you do both operations in O(1) time complexity?
#
# Example:
#
# LRUCache cache = new LRUCache( 2 /* capacity */ );
#
# cache.put(1, 1);
# cache.put(2, 2);
# cache.get(1);       // returns 1
# cache.put(3, 3);    // evicts key 2
# cache.get(2);       // returns -1 (not found)
# cache.put(4, 4);    // evicts key 1
# cache.get(1);       // returns -1 (not found)
# cache.get(3);       // returns 3
# cache.get(4);       // returns 4


# Hash + Doubly linked list

class LRUCache

  def initialize(capacity)
    @h = {}
    @cap = capacity
    @ddl = DDL.new
  end

  def get(key)
    return -1 if !@h.has_key?(key) # don't have the key
    node = @h[key]                 # get the node
    @ddl.delete(node)              # delete the node
    @ddl.unshift(node)             # unshift the node
    node.val
  end

  def put(key, value)
    if @h.has_key?(key)
      node = @h[key]
      node.val = value
      @ddl.delete(node) and @ddl.unshift(node) if @ddl.first != node
    else
      if @h.size == @cap
        @h.delete(@ddl.last.key)
        @ddl.pop
      end
      node = Node.new(key, value)
      @h[key] = node
      @ddl.unshift(node)
    end
  end

  private

  class Node
    attr_accessor :key, :val, :next, :prev
    def initialize(key, val=key)
      @key, @val, @next, @prev = key, val, nil, nil
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
  end
end


# Or use some Ruby magic...

class LRUCache

  def initialize(capacity)
    @capacity = capacity
    @cache = {}
  end

  def get(key)
    return -1 if !@cache.has_key?(key)
    value = @cache.delete(key)
    @cache[key] = value
    value
  end

  def put(key, value)
    if @cache.has_key?(key)
      @cache.delete(key)
    elsif @cache.size == @capacity
      @cache.shift              # Magic...
    end
    @cache[key] = value
  end
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_lru
    cache = LRUCache.new(2)
    cache.put(1, 1)
    cache.put(2, 2)
    assert_equal cache.get(1), 1
    cache.put(3, 3)
    assert_equal cache.get(2), -1
    cache.put(4, 4)
    assert_equal cache.get(1), -1
    assert_equal cache.get(3), 3
    assert_equal cache.get(4), 4
  end
end
