# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=5016 lang=ruby
#
# [5016] Remove Outermost Parentheses
#
# https://leetcode.com/problems/remove-outermost-parentheses/description/
#
# A valid parentheses string is either empty (""), "(" + A + ")", or A
# + B, where A and B are valid parentheses strings, and + represents
# string concatenation. For example, "", "()", "(())()", and
# "(()(()))" are all valid parentheses strings.
#
# A valid parentheses string S is primitive if it is nonempty, and
# there does not exist a way to split it into S = A+B, with A and B
# nonempty valid parentheses strings.
#
# Given a valid parentheses string S, consider its primitive
# decomposition: S = P_1 + P_2 + ... + P_k, where P_i are primitive
# valid parentheses strings.
#
# Return S after removing the outermost parentheses of every primitive
# string in the primitive decomposition of S.
#
# Example 1:
#
# Input: "(()())(())"
# Output: "()()()"
# Explanation: The input string is "(()())(())", with primitive
# decomposition "(()())" + "(())". After removing outer parentheses of
# each part, this is "()()" + "()" = "()()()".
#
# Example 2:
#
# Input: "(()())(())(()(()))"
# Output: "()()()()(())"
# Explanation: The input string is "(()())(())(()(()))", with
# primitive decomposition "(()())" + "(())" + "(()(()))". After
# removing outer parentheses of each part, this is "()()" + "()" +
# "()(())" = "()()()()(())".
#
# Example 3:
#
# Input: "()()"
# Output: ""
# Explanation:
# The input string is "()()", with primitive decomposition "()" + "()".
# After removing outer parentheses of each part, this is "" + "" = "".
#
# Note:
#
# S.length <= 10000
# S[i] is "(" or ")"
# S is a valid parentheses string


# At first stack comes into my mind.

# @param {String} s
# @return {String}
def remove_outer_parentheses(s)
  str, stack, start = "", [], 0
  s.chars.each_with_index do |c, i|
    if stack.empty?
      stack << c
      start = i
    else
      if c == '('
        stack << c
      elsif stack[-1] == '('
        stack.pop
        if stack.empty?
          x = s[start+1..i-1]
          str << x if !x.nil?
        end
      end
    end
  end
  str
end


# Then I realized that we just need to keep record of the number of parentheses.

def remove_outer_parentheses(s)
  ans, p = "", 0
  s.chars.each do |c|
    if c == '('
      ans << c if p > 0
      p += 1
    else
      ans << c if p > 1
      p -= 1
    end
  end
  ans
end
