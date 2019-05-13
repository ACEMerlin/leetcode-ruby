# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=171 lang=ruby
#
# [171] Excel Sheet Column Number
#
# https://leetcode.com/problems/excel-sheet-column-number/description/
#
# Given a column title as appear in an Excel sheet, return its
# corresponding column number.
#
# For example:
#
# ⁠   A -> 1
# ⁠   B -> 2
# ⁠   C -> 3
# ⁠   ...
# ⁠   Z -> 26
# ⁠   AA -> 27
# ⁠   AB -> 28
# ⁠   ...
#
# Example 1:
#
# Input: "A"
# Output: 1
#
# Example 2:
#
# Input: "AB"
# Output: 28
#
# Example 3:
#
# Input: "ZY"
# Output: 701


# @param {String} s
# @return {Integer}
def title_to_number(s)
  sum = 0
  s.each_char do |c|
    o = c.ord-64
    sum = 26 * sum + o
  end
  sum
end
