# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=119 lang=ruby
#
# [119] Pascal's Triangle II
#
# https://leetcode.com/problems/pascals-triangle-ii/description/
#
# Given a non-negative index k where k ≤ 33, return the kth index row
# of the Pascal's triangle.
#
# Note that the row index starts from 0.
#
# In Pascal's triangle, each number is the sum of the two numbers
# directly above it.
#
# Example:
#
# Input: 3
# Output: [1,3,3,1]
#
# Follow up:
#
# Could you optimize your algorithm to use only O(k) extra space?


# @param {Integer} row_index
# @return {Integer[]}
def get_row(row_index, x=[1], k=0)
  return x if k == row_index
  k += 1
  cur = (1..k-1).map { |i| x[i-1]+x[i] }
  cur.unshift 1
  cur << 1
  get_row(row_index, cur, k)
end


# O(k) space.

def get_row(row_index)
  x = Array.new(row_index+1, 0).tap { |h| h[0] = 1 }
  (1..row_index).each do |i|
    i.downto(1).each do |j|
      x[j] += x[j-1]
    end
  end
  x
end
