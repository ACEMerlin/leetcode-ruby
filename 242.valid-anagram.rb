# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=242 lang=ruby
#
# [242] Valid Anagram
#
# https://leetcode.com/problems/valid-anagram/description/
#
# Given two strings s and t, write a function to determine if t is an
# anagram of s.
#
# Example 1:
#
# Input: s = "anagram", t = "nagaram"
# Output: true
#
# Example 2:
#
# Input: s = "rat", t = "car"
# Output: false
#
# Note:
# You may assume the string contains only lowercase alphabets.
#
# Follow up:
# What if the inputs contain unicode characters? How would you adapt your
# solution to such case?


# @param {String} s
# @param {String} t
# @return {Boolean}
def is_anagram(s, t)
  return false if s.size != t.size
  s.chars.sort == t.chars.sort
end


def is_anagram(s, t)
  return false if s.size != t.size
  !(0..s.size-1).reduce({}) do |h, i|
    h[s[i]] += 1
    h[t[i]] -= 1
    h
  end.any? { |_, v| v != 0 }
end
