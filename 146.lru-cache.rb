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
    @size = 0
    @cap = capacity
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.prev = @tail
    @tail.next = @head
  end

  def get(key)
    return -1 if !@h.has_key?(key)
    node = @h[key]
    delete(node)
    insert_tail(node)
    node.val
  end

  def put(key, value)
    if @h.has_key?(key)
      node = @h[key]
      node.val = value
      delete(node)
    else
      if @size == @cap
        @h.delete(@head.prev.key)
        delete(@head.prev)
      end
      node = Node.new(key, value)
      @h[key] = node
    end
    insert_tail(node)
  end

  def debug
    cur, str = @tail, ""
    while !cur.nil?
      str << cur.val.to_s
      cur = cur.next
    end
    puts str
  end

  private

  def insert_tail(node)
    t = @tail.next
    @tail.next = node
    node.prev = @tail
    t.prev = node
    node.next = t
    @size += 1
  end

  def delete(node)
    node.prev.next = node.next
    node.next.prev = node.prev
    @size -= 1
  end

  class Node
    attr_accessor :key, :val, :next, :prev
    def initialize(key, val=key)
      @key, @val, @next, @prev = key, val, nil, nil
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
