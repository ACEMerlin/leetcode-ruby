# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=266 lang=ruby
#
# [266] Palindrome Permutation
#
# https://leetcode.com/problems/palindrome-permutation/description/
#
# Given a string, determine if a permutation of the string could form a palindrome.
#
# For example, "code" -> False, "aab" -> True, "carerac" -> True.

def can_permute_palindrome(s)
  t, n = Set.new, 0
  s.chars.each do |c|
    if t.include?(c)
      n -= 1
      t.delete(c)
    else
      n += 1
      t << c
    end
  end
  n <= 1
end
