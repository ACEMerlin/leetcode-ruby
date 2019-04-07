# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=409 lang=ruby
#
# [409] Longest Palindrome
#
# https://leetcode.com/problems/longest-palindrome/description/
#
# Given a string which consists of lowercase or uppercase letters, find the
# length of the longest palindromes that can be built with those letters.
#
# This is case sensitive, for example "Aa" is not considered a palindrome here.
#
# Note: Assume the length of given string will not exceed 1,010.
#
# Example:
#
# Input:
# "abccccdd"
# Output:
# 7
# Explanation:
# One longest palindrome that can be built is "dccaccd", whose length is 7.


# @param {String} s
# @return {Integer}
def longest_palindrome(s)
  t, ans = Set.new, 0
  s.chars.each do |c|
    if t.include?(c)
      t.delete(c)
      ans += 2
    else
      t << c
    end
  end
  ans == s.length ? ans : ans+1
end
