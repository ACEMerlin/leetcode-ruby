# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=706 lang=ruby
#
# [706] Design HashMap
#
# https://leetcode.com/problems/design-hashmap/description/
#
# Design a HashMap without using any built-in hash table libraries.
#
# To be specific, your design should include these functions:
#
# put(key, value) : Insert a (key, value) pair into the HashMap. If the value
# already exists in the HashMap, update the value.
# get(key): Returns the value to which the specified key is mapped, or -1 if
# this map contains no mapping for the key.
# remove(key) : Remove the mapping for the value key if this map contains the
# mapping for the key.
#
# Example:
#
# MyHashMap hashMap = new MyHashMap();
# hashMap.put(1, 1);
# hashMap.put(2, 2);
# hashMap.get(1); // returns 1
# hashMap.get(3); // returns -1 (not found)
# hashMap.put(2, 1); // update the existing value
# hashMap.get(2); // returns 1
# hashMap.remove(2); // remove the mapping for 2
# hashMap.get(2); // returns -1 (not found)
#
# Note:
#
# All keys and values will be in the range of [0, 1000000].
# The number of operations will be in the range of [1, 10000].
# Please do not use the built-in HashMap library.


# Hash Table with separate chanining
class MyHashMap

  def initialize()
    @m = 1000
    @st = Array.new(@m)
  end

  def put(key, value)
    i = my_hash(key)
    x = @st[i]
    until x.nil?
      x.val = value and return if x.key == key
      x = x.next
    end
    @st[i] = Node.new(key, value, @st[i])
  end

  def get(key)
    i = my_hash(key)
    x = @st[i]
    until x.nil?
      return x.val if x.key == key
      x = x.next
    end
    -1
  end

  def remove(key)
    i = my_hash(key)
    x = @st[i]
    if !x.nil? && x.key == key
      @st[i] = x.next
      return
    end
    while !x.nil? && x.key != key
      prev = x
      x = x.next
    end
    return if x.nil?
    prev.next = x.next
  end

  private

  def my_hash(key)
    key.hash % @m
  end

  class Node
    attr_accessor :key, :val, :next
    def initialize(k, v, n)
      @key, @val, @next = k, v, n
    end
  end
end


# Hash Table with open addressing
class MyHashMap

  def initialize()
    @m = 30007
    @vals = Array.new(@m)
    @keys = Array.new(@m)
  end

  def put(key, value)
    i = my_hash(key)
    while !@keys[i].nil?
      break if key == @keys[i]
      i = (i+1) % @m
    end
    @keys[i], @vals[i] = key, value
  end

  def get(key)
    i = my_hash(key)
    while !@keys[i].nil?
      return @vals[i] if key == @keys[i]
      i = (i+1) % @m
    end
    -1
  end

  def remove(key)
    i = my_hash(key)
    while !@keys[i].nil?
      break if key == @keys[i]
      i = (i+1) % @m
    end
    @keys[i], @vals[i] = nil, nil
    i = (i+1) % @m
    while !@keys[i].nil?
      k, v = @keys[i], @vals[i]
      @keys[i], @vals[i] = nil, nil
      put(k, v)
      i = (i+1) % @m
    end
  end

  private

  def my_hash(key)
    key.hash % @m
  end

  class Node
    attr_accessor :key, :val, :next
    def initialize(k, v, n)
      @key, @val, @next = k, v, n
    end
  end
end
