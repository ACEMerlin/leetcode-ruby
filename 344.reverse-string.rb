# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=344 lang=ruby
#
# [344] Reverse String
#
# https://leetcode.com/problems/reverse-string/description/
#
# Write a function that reverses a string. The input string is given
# as an array of characters char[].
#
# Do not allocate extra space for another array, you must do this by
# modifying the input array in-place with O(1) extra memory.
#
# You may assume all the characters consist of printable ascii characters.
#
# Example 1:
#
# Input: ["h","e","l","l","o"]
# Output: ["o","l","l","e","h"]
#
# Example 2:
#
# Input: ["H","a","n","n","a","h"]
# Output: ["h","a","n","n","a","H"]


# @param {Character[]} s
# @return {Void} Do not return anything, modify s in-place instead.
def reverse_string(s)
  i, j = 0, s.length-1
  until i > j
    s[i], s[j] = s[j], s[i]
    i += 1
    j -= 1
  end
  s
end
