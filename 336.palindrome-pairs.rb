# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=336 lang=ruby
#
# [336] Palindrome Pairs
#
# https://leetcode.com/problems/palindrome-pairs/description/
#
# Given a list of unique words, find all pairs of distinct indices (i,
# j) in the given list, so that the concatenation of the two words,
# i.e. words[i] + words[j] is a palindrome.
#
# Example 1:
#
# Input: ["abcd","dcba","lls","s","sssll"]
# Output: [[0,1],[1,0],[3,2],[2,4]]
# Explanation: The palindromes are ["dcbaabcd","abcddcba","slls","llssssll"]
#
# Example 2:
#
# Input: ["bat","tab","cat"]
# Output: [[0,1],[1,0]]
# Explanation: The palindromes are ["battab","tabbat"]


# Trie.
#
# 1. Build Trie with each word reversed.
# 2. Given w1, walk down the trie till find a word w2:
#    - w1.size >= w2.size: check if the rest of w1 is palindrome.
#    - w1.size < w2.size: check if any word down below w2 is palindrome.
# 3. One edge case is the empty string "", it can pair with any palindrome string.

# @param {String[]} words
# @return {Integer[][]}
def palindrome_pairs(words)
  trie = build_trie(words)
  h = words.zip(words.size.times).to_h
  ans = words.each_with_index.reduce([]) do |a, (w, i)|
    a.concat sub_palindrome(w, trie).map { |x| [i, h[x]] }
  end
  if h.has_key?("")
    e = h[""]
    ps = words.select { |x| palindrome?(x) }
    ps.each do |w|
      next if w.empty?
      ans << [h[w], e]
      ans << [e, h[w]]
    end
  end
  ans
end

def sub_palindrome(word, trie, ans=[])
  i = 0
  while i < word.size
    trie = trie.next[word[i]]
    break if trie.nil?
    if !trie.word.nil? && word != trie.word && palindrome?(word[i+1..-1])
      ans << trie.word
    end
    i += 1
  end
  ans.concat(trie.pd) if !trie.nil?
  ans
end

def build_trie(words)
  root = Trie.new
  words.each do |o|
    w = o.reverse
    cur = root
    w.each_char.with_index do |c, i|
      cur.next[c] = Trie.new if !cur.next.has_key?(c)
      cur = cur.next[c]
      rest = w[i+1, w.size-i-1]
      cur.pd << o if !rest.empty? && palindrome?(rest)
    end
    cur.word = o
  end
  root
end

def palindrome?(w)
  i, j = 0, w.size-1
  while i < j
    return false if w[i] != w[j]
    i += 1
    j -= 1
  end
  true
end

class Trie
  attr_accessor :word, :pd, :next

  def initialize
    @word, @pd, @next = nil, [], {}
  end
end
