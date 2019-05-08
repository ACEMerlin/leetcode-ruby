# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=22 lang=ruby
#
# [22] Generate Parentheses
#
# https://leetcode.com/problems/generate-parentheses/description/
#
# Given n pairs of parentheses, write a function to generate all
# combinations of well-formed parentheses.
#
# For example, given n = 3, a solution set is:
# [
# ⁠ "((()))",
# ⁠ "(()())",
# ⁠ "(())()",
# ⁠ "()(())",
# ⁠ "()()()"
# ]


# DFS.
#
# See: https://stackoverflow.com/a/23414519

# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
  dfs(n, n)
end

def dfs(o, c, s="", paths=[])
  return if o > c || c < 0 || o < 0
  if o == 0
    paths << "#{s}#{')'*c}"
  else
    dfs(o-1, c, s+"(", paths)
    dfs(o, c-1, s+")", paths)
  end
  paths
end
