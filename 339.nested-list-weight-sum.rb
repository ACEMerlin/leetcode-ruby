# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=339 lang=ruby
#
# [339] Nested List Weight Sum
#
# https://leetcode.com/problems/nested-list-weight-sum/description/
#
# Given a nested list of integers, return the sum of all integers in
# the list weighted by their depth.
#
# Each element is either an integer, or a list -- whose elements may
# also be integers or other lists.
#
# Example 1:
# Given the list [[1,1],2,[1,1]], return 10.
# (four 1's at depth 2, one 2 at depth 1)
#
# Example 2:
# Given the list [1,[4,[6]]], return 27.
# (one 1 at depth 1, one 4 at depth 2, and one 6 at depth 3; 1 + 4*2 + 6*3 = 27)

def depth_sum(list, d=1)
  list.reduce(0) do |s, n|
    if n.is_a? Array
      s += depth_sum(n, d+1)
    else
      s += n * d
    end
  end
end
