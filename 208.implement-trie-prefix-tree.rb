# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=208 lang=ruby
#
# [208] Implement Trie (Prefix Tree)
#
# https://leetcode.com/problems/implement-trie-prefix-tree/description/
#
# Implement a trie with insert, search, and startsWith methods.
#
# Example:
#
# Trie trie = new Trie();
#
# trie.insert("apple");
# trie.search("apple");   // returns true
# trie.search("app");     // returns false
# trie.startsWith("app"); // returns true
# trie.insert("app");
# trie.search("app");     // returns true
#
# Note:
#
# You may assume that all inputs are consist of lowercase letters a-z.
# All inputs are guaranteed to be non-empty strings.


class Trie

  def initialize
    @root = Node.new
  end

  def insert(word, x=@root, k=0)
    x = Node.new if x.nil?
    if k == word.size
      x.val = true
      return x
    end
    c = ord(word[k])
    x.next[c] = insert(word, x.next[c], k+1)
    x
  end

  def search(word, x=@root, k=0)
    return false if x.nil?
    return !x.val.nil? if k == word.size
    c = ord(word[k])
    search(word, x.next[c], k+1)
  end

  def starts_with(prefix, x=@root, k=0)
    return false if x.nil?
    return true if k == prefix.size
    c = ord(prefix[k])
    starts_with(prefix, x.next[c], k+1)
  end

  private

  def ord(s)
    s.ord - 'a'.ord
  end

  class Node
    attr_accessor :val, :next
    def initialize
      @val, @next = nil, Array.new(26)
    end
  end
end
