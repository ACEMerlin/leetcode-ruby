# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=125 lang=ruby
#
# [125] Valid Palindrome
#
# https://leetcode.com/problems/valid-palindrome/description/
#
# Given a string, determine if it is a palindrome, considering only
# alphanumeric characters and ignoring cases.
#
# Note: For the purpose of this problem, we define empty string as
# valid palindrome.
#
# Example 1:
#
# Input: "A man, a plan, a canal: Panama"
# Output: true
#
# Example 2:
#
# Input: "race a car"
# Output: false


# @param {String} s
# @return {Boolean}
def is_palindrome(s)
  pl?(s.downcase.gsub(/[^a-z0-9]+/, ""))
end

def pl?(s)
  i, j = 0, s.size-1
  while i < j
    return false if s[i] != s[j]
    i += 1
    j -= 1
  end
  true
end
