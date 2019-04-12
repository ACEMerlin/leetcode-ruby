# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=387 lang=ruby
#
# [387] First Unique Character in a String
#
# https://leetcode.com/problems/first-unique-character-in-a-string/description/
#
# Given a string, find the first non-repeating character in it and
# return it's index. If it doesn't exist, return -1.
#
# Examples:
#
# s = "leetcode"
# return 0.
#
# s = "loveleetcode",
# return 2.
#
# Note: You may assume the string contain only lowercase letters.


# One-liner.

# @param {String} s
# @return {Integer}
def first_uniq_char(s)
  s.chars.each_with_index.reduce(Hash.new { |h, k| h[k] = [0, 0] }) { |h, (c, i)| h[c][0] += 1; h[c][1] = i; h }.each { |c, (f, i)| return i if f == 1 }
  -1
end
