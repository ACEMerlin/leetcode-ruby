# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=20 lang=ruby
#
# [20] Valid Parentheses
#
# https://leetcode.com/problems/valid-parentheses/description/
#
# Given a string containing just the characters '(', ')', '{', '}',
# '[' and ']', determine if the input string is valid.
#
# An input string is valid if:
#
# Open brackets must be closed by the same type of brackets.
# Open brackets must be closed in the correct order.
#
# Note that an empty string is also considered valid.
#
# Example 1:
#
# Input: "()"
# Output: true
#
# Example 2:
#
# Input: "()[]{}"
# Output: true
#
# Example 3:
#
# Input: "(]"
# Output: false
#
# Example 4:
#
# Input: "([)]"
# Output: false
#
# Example 5:
#
# Input: "{[]}"
# Output: true



# @param {String} s
# @return {Boolean}
def is_valid(s)
  st = []
  s.chars.each do |c|
    t = st[-1]
    if c == ']' && t == '[' ||
        c == '}' && t == '{' ||
        c == ')' && t == '('
      st.pop
    else
      st << c
    end
  end
  st.empty?
end
