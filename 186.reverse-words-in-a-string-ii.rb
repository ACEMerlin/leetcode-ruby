# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=186 lang=ruby
#
# [186] Reverse Words in a String II
#
# https://leetcode.com/problems/reverse-words-in-a-string-ii/description/
#
# Given an input string, reverse the string word by word. A word is
# defined as a sequence of non-space characters. The input string does
# not contain leading or trailing spaces and the words are always
# separated by a single space.
#
# For example,
# Given s = "the sky is blue",
# return "blue is sky the".
#
# Could you do it in-place without allocating extra space?


# See problem 189.

#   1. Reverse the whole string.
#   2. Reverse each word.

def reverse_words(s)
  s.reverse!
  i = 0
  while i < s.size
    if s[i] == ' '
      i += 1
    else
      j = i
      i += 1 while i < s.size && s[i] != ' '
      reverse(s, j, i-1)
    end
  end
  s
end

def swap(nums, i, j)
  nums[i], nums[j] = nums[j], nums[i]
end

def reverse(nums, i, j)
  until i > j
    swap(nums, i, j)
    i += 1
    j -= 1
  end
end
