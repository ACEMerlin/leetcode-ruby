# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=678 lang=ruby
#
# [678] Valid Parenthesis String
#
# https://leetcode.com/problems/valid-parenthesis-string/description/
#
# Given a string containing only three types of characters: '(', ')'
# and '*', write a function to check whether this string is valid. We
# define the validity of a string by these rules:
#
# - Any left parenthesis '(' must have a corresponding right parenthesis ')'.
# - Any right parenthesis ')' must have a corresponding left parenthesis '('.
# - Left parenthesis '(' must go before the corresponding right parenthesis ')'.
# - '*' could be treated as a single right parenthesis ')' or a single left
#   parenthesis '(' or an empty string.
# - An empty string is also valid.
#
# Example 1:
#
# Input: "()"
# Output: True
#
# Example 2:
#
# Input: "(*)"
# Output: True
#
# Example 3:
#
# Input: "(*))"
# Output: True
#
# Note:
#
# The string size will be in the range [1, 100].


# Using two stacks:
#
#   1. we are storing charater's index in both of the stack.
#   2. iterate through the string:
#      - put indices of '('s in the first stack s1.
#      - put indices of '*'s in the second stack s2.
#      - when encountering a ')', use '(' from s1 to match it first,
#        only when s1 is empty, use '*' from s2 to match it. when both
#        s1 and s2 are empty, return false.
#   3. at this point, we need '('s from s1 to match the '*'s from s2.
#      - if the index of '(' in s1 is bigger than the index of '*' in
#        s2, return false.
#      - if s2 is empty and s1 is not, return false.
#      - otherwise pop from both s1 and s2.

# @param {String} s
# @return {Boolean}
def check_valid_string_a(s)
  open_paren_stack = []
  star_stack = []
  s.size.times do |i|
    if s[i] == '('
      open_paren_stack << i
    elsif s[i] == '*'
      puts s[i]
      star_stack << i
    else
      if !open_paren_stack.empty?
        open_paren_stack.pop
      elsif !star_stack.empty?
        star_stack.pop
      else
        return false
      end
    end
  end
  until open_paren_stack.empty?
    return false if star_stack.empty? || open_paren_stack[-1] > star_stack[-1]
    open_paren_stack.pop
    star_stack.pop
  end
  true
end


# From Leecode discussion.
# max: treat '*' as '(', if encountering an '(' or '*' then max++ else max--.
# min: treat '*' as ')' or '', if encountering an ')' or '*' then min=[min-1,0].max else min++.
#
#   1. if max < 0, it means that although we have treated all '*' as '(',
#      there still are too much ')'.
#   2. if min < 0, it means that we use too many '*' as ')', so we
#      just reset it to 0 to indicate that juse don't use that many '*'.
#   3. if min > 0, then it means that there are too much '('.
#   4. only when max > 0 at all time and min == 0 in the end, then it's
#      a valid string.

def check_valid_string(s)
  max = min = 0
  s.chars.each do |c|
    if c != ')'
      max += 1
    else
      max -= 1
    end
    if c != '('
      min = [min-1, 0].max
    else
      min += 1
    end
    return false if max < 0
  end
  min == 0
end
